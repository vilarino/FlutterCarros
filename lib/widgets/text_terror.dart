import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  @override
  String msg;
  Function onPressed;

  TextError({this.msg, this.onPressed});

  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          this.msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
