import 'package:flutter/material.dart';
class MyPlayer extends StatelessWidget {
  final playerX;
   MyPlayer({Key? key,this.playerX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX,1),
      child: ClipRRect(
        borderRadius:BorderRadius.circular(10),
        child: Container(
          color: Colors.blueAccent,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
