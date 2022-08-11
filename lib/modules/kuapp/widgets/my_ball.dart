import 'package:flutter/material.dart';
class MyBall extends StatelessWidget {
  final  ballX;
  final  ballY;
  const MyBall({Key? key,required this.ballX,required this.ballY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX,ballY),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red
        ),
      ),
    );
  }
}
