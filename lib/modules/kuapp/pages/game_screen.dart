import 'dart:async';

import 'package:demo_bloc_ku/modules/kuapp/widgets/my_ball.dart';
import 'package:demo_bloc_ku/modules/kuapp/widgets/my_button.dart';
import 'package:demo_bloc_ku/modules/kuapp/widgets/my_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/my_missile.dart';
class GameScreenPage extends StatefulWidget {
  const GameScreenPage({Key? key}) : super(key: key);

  @override
  State<GameScreenPage> createState() => _GameScreenPageState();
}
enum direction{LEFT,RIGHT}

class _GameScreenPageState extends State<GameScreenPage> {
  static double playerX = 0;
  double missileX = playerX;
  double  missileY = 1;
  double  missileHeight = 10;
  bool misShot = false;
  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;
  void moveLeft(){
    setState(() {
      if(playerX - 0.1 < -1){
        //
      }else{
        playerX-=0.1;
      }
      if(!misShot){
        missileX = playerX;
      }
    });

  }
  void moveRight(){
    setState(() {
      missileX = playerX;
      if(playerX + 0.1 > 1){
        //
      }else{
        playerX+= 0.1;
      }
      missileX = playerX;
    });

  }
  void fireMissile(){
    if(misShot == false){
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        misShot = true;
        setState(() {
          missileHeight+=10;
        });
        if(missileHeight> MediaQuery.of(context).size.height*3/4){
          resetMissile();
          timer.cancel();
        }
        if(ballY > heightToPosition(missileHeight) && (ballX-missileX).abs() < 0.03){
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }


  }
  void resetMissile(){
    missileX = playerX;
    missileHeight = 10;
    misShot = false;
  }
  bool playerDies(){
    if((ballX-playerX).abs()<0.05 && ballY >=0.95){
      return true;
    }else{
      return false;
    }
  }
  double heightToPosition(double height){
    double totalHeight = MediaQuery.of(context).size.height * 3/4;
    double position = 1-2*height/totalHeight;
    return position;
  }
  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: const Center(
              child: Text('Ban da thua',style: TextStyle(color: Colors.white),),
            ),
          );
        }
    );
  }
  void startGame(){
    double time = 0;
    double height = 0;
    double velocity = 60;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {

      height = -5 * time *time + velocity * time;
      if(height<0){
        time = 0;
      }
      setState(() {
        ballY = heightToPosition(height);
      });
      if(ballX - 0.005 < -1){
        ballDirection = direction.RIGHT;
      }else if(ballX + 0.005 >1){
        ballDirection = direction.LEFT;
      }
      if(ballDirection == direction.LEFT){
        setState(() {
          ballX -=0.005;
        });
      }else if(ballDirection == direction.RIGHT){
        setState(() {
          ballX += 0.005;
        });
      }
      if(playerDies()){
        timer.cancel();
        _showDialog();
      }
      time +=0.1;


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (even){
          if(even.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
            moveLeft();
          }else if(even.isKeyPressed(LogicalKeyboardKey.arrowRight)){
            moveRight();
          }
          if(even.isKeyPressed(LogicalKeyboardKey.space)){
            fireMissile();
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.greenAccent,
                child: Center(
                  child: Stack(
                    children: [
                      MyBall(ballX: ballX,ballY: ballY,),
                      MyMissile(
                        missileX: missileX,
                        height: missileHeight,
                      ),
                      MyPlayer(playerX: playerX,),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      icon: const Icon(Icons.play_arrow),
                      function: startGame,
                    ),
                    MyButton(
                      icon: const Icon(Icons.arrow_back),
                      function: moveLeft,
                    ),
                    MyButton(
                      icon: const Icon(Icons.arrow_upward),
                      function: fireMissile,
                    ),
                    MyButton(
                      icon: const Icon(Icons.arrow_forward),
                      function: moveRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
