import 'dart:async';

import 'package:carros/api/carro_api.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/bloc/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/carro/carro_listview.dart';
import 'package:carros/widgets/text_terror.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  @override
  _CarrosPageState createState() => _CarrosPageState();

  String tipo;

  CarrosPage({this.tipo});
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            msg: "Falha ao carregar carros",
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(widget.tipo);
  }
}
