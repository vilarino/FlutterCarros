import 'dart:async';

import 'package:carros/api/login_api.dart';
import 'package:carros/api/response_api.dart';
import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/models/usuario.dart';

class LoginBloc extends BaseBloc<bool>{

  Future<ResponseApi<Usuario>> login(String login, String password) async {
    add(true);
    ResponseApi response = await LoginApi.login(login, password);
    add(false);
    return response;
  }
}
