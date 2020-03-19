import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace) {
    // pushReplacement substitui
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
  // push empilha, aí aparece o botão de voltar
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}
