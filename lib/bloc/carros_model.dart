import 'package:carros/api/carro_api.dart';
import 'package:carros/models/carro.dart';
import 'package:mobx/mobx.dart';
part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {

  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  fetch(String tipo) async {
    try {
      error = null;

      this.carros = await CarroApi.getCarros(tipo);

    } catch (e) {
      this.error = e;
    }
  }
}
