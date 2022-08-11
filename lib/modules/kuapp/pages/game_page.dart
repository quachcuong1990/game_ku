import 'package:demo_bloc_ku/modules/kuapp/utils/game.dart';
import 'package:demo_bloc_ku/modules/kuapp/widgets/figure_image.dart';
import 'package:demo_bloc_ku/modules/kuapp/widgets/letter.dart';
import 'package:flutter/material.dart';

import '../ui/colors.dart';
class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String word = 'Flutter'.toUpperCase();
  List<String> alphabets = [
    'A','B','C','D','E','F','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text('Hangman'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, 'assets/images/hang.png'),
                figureImage(Game.tries >= 1, 'assets/images/head.png'),
                figureImage(Game.tries >= 2, 'assets/images/body.png'),
                figureImage(Game.tries >= 3, 'assets/images/ra.png'),
                figureImage(Game.tries >= 4, 'assets/images/la.png'),
                figureImage(Game.tries >= 5, 'assets/images/rl.png'),
                figureImage(Game.tries >= 6, 'assets/images/ll.png'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e
                .toUpperCase(), !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: GridView.count(
                crossAxisCount: 6,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            padding: EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                  ?null
                  :(){
                    setState((){
                      Game.selectedChar.add(e);
                      print(Game.selectedChar);
                      if(!word.split('').contains(e.toUpperCase())){
                        Game.tries++;
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),),
                  fillColor: Game.selectedChar.contains(e)
                      ?Colors.black87
                      :Colors.blue,
                );
              }).toList(),
            ),
          )
        ],
      ),

    );
  }
}
