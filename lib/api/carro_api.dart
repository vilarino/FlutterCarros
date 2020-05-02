import 'dart:convert' as convert;
import 'package:carros/dao/carro_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class CarroApi {
  static final String classicos ="classicos";
  static final String esportivos ="esportivos";
  static final String luxo ="luxo";

  static const URL = "https://carros-springboot.herokuapp.com/api/v2/carros";

  static Future<List<Carro>> getCarros(String tipo) {
    return CarroApi.getOnServer("${CarroApi.URL}/tipo/$tipo");
  }

  static Future<List<Carro>> getOnServer(url) async {

    print("GET -> $url");
    Usuario usuario = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer ${usuario.token}"

    };
    var response = await http.get(url, headers: headers);
    List list = convert.json.decode(response.body);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    final CarroDAO carroDAO = CarroDAO();
    carros.forEach((Carro carro) => carroDAO.save(carro));

    return carros;
  }
}