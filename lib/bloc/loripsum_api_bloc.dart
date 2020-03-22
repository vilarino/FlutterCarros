import 'package:carros/api/loripsum_api.dart';

import 'base_bloc.dart';

class LoripsumBloc extends BaseBloc<String> {
  static String textLorim;

  fetch() async {
    try {
      String text = LoripsumBloc.textLorim ?? await LoripsumApi.getLoripsum();
      textLorim = text;
      add(text);
    } catch (e) {
      addError(e);
    }
  }
}
