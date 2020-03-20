import 'dart:async';

import 'package:carros/api/carro_api.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  @override
  _CarrosListViewState createState() => _CarrosListViewState();

  String tipo;

  CarrosListView({this.tipo});
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;
  final _streamController = StreamController<List<Carro>>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  @override
  void initState() {
    super.initState();
    _loadCarros();
  }


  _loadCarros() async {
    List<Carro> carros = await CarroApi.getCarros(widget.tipo);

    _streamController.add(carros);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível buscar os carros",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro carro = carros[index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        carro.urlFoto ??
                            "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg",
                        width: 250,
                      ),
                    ),
                    Text(
                      carro.nome ?? 'Nome não cadastrado',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      'descrição..',
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Icon(Icons.zoom_in),
                            onPressed: () => _onClickCarros(carro),
                          ),
                          FlatButton(
                            child: Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _onClickCarros(Carro carro) {
    push(context, CarroPage(carro));
  }
}
