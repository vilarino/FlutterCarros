import 'package:carros/dao/database_helper.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future futureDB = DatabaseHelper.getInstance().db;

    Future<Usuario> futureUsuario = Usuario.get();

    Future futureTempo = Future.delayed(Duration(seconds: 3));

//    future.then((Usuario usuario) {
//      if (usuario != null) {
//        setState(() {
//          push(context, HomePage(), replace: true);
//          //_tLogin.text = usuario.login;
//        });
//      }
//    });

    Future.wait([futureDB, futureUsuario, futureTempo]).then((List values) {
      Usuario usuario = values[1];
      if (usuario != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
