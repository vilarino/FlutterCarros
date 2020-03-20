import 'dart:async';

import 'package:carros/api/response_api.dart';
import 'package:carros/api/login_api.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _streamController = StreamController<bool>();

  final TextEditingController _tLogin = TextEditingController();
  final TextEditingController _tPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusPassword = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<Usuario> future = Usuario.get();

    future.then((Usuario usuario) {
      if (usuario != null) {
        setState(() {
          push(context, HomePage(), replace: true);
          //_tLogin.text = usuario.login;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Carros")),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite email",
              controller: _tLogin,
              validator: _validateLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPassword,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Senha",
              "Digite a senha",
              password: true,
              controller: _tPassword,
              validator: _validatePassword,
              keyboardType: TextInputType.number,
              focusNode: _focusPassword,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data ?? false,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    String login = _tLogin.text;
    String password = _tPassword.text;

    _streamController.add(true);
    _streamController.add(true);

    ResponseApi response = await LoginApi.login(login, password);

    if (response.ok) {
      Usuario user = response.result;
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

    _streamController.add(false);
  }

  String _validateLogin(String text) {
    return text.isEmpty ? "Digite o login" : null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }

    if (text.length < 3) {
      return "Senha muito curta";
    }

    return null;
  }

  @override
  void dispose(){
    super.dispose();

    _streamController.close();
  }
}
