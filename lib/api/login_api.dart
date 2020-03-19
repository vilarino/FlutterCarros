import 'dart:convert';

import 'package:carros/api/response_api.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ResponseApi<Usuario>> login(String login, String password) async {
    try{
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map params = {'username': login, 'password': password};

      Map<String, String> headers = {"Content-Type": "application/json"};

      var response =
      await http.post(url, body: json.encode(params), headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final usuario = Usuario.fromJson(mapResponse);
        usuario.save();
        return ResponseApi.ok(usuario);
      }

      return ResponseApi.error(mapResponse['error']);
    }catch(error, exeception){
      print("Error no login $error > $exeception");

      return ResponseApi.error("Não foi possível fazer o login");
    }
  }
}
