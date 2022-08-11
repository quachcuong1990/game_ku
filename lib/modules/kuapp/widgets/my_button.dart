import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  Widget? icon;
  VoidCallback? function;
   MyButton({Key? key,this.icon,this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.grey,
        width: 50,
        height: 50,
        child: icon,
      ),
    );
  }
}
