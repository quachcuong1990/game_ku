import 'package:flutter/material.dart';
class MyMissile extends StatelessWidget {
  final missileX;
  final height;
  const MyMissile({Key? key,this.missileX,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX,1),
      child: Container(
        color: Colors.red,
        width: 2,
        height: height,
      ),
    );
  }
}
