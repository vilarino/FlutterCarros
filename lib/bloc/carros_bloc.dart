import 'dart:async';

import 'package:carros/api/carro_api.dart';
import 'package:carros/models/carro.dart';

import 'base_bloc.dart';

class CarrosBloc extends BaseBloc<List<Carro>>{

  fetch(String tipo) async {
    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
