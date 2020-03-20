import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  @override
  String msg;

  TextError({this.msg});

  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.msg,
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
        ),
      ),
    );
  }
}
