import 'package:carros/api/carro_api.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/carro/carro_listview.dart';
import 'package:carros/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    // Primeiro busca o índice nas prefs.
    int tabIndex = await Prefs.getInt("tabIndex");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 3, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController.index = tabIndex;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIndex", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Carros'),
          bottom: _tabController == null
              ? null
              : TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      text: "Clássicos",
                    ),
                    Tab(
                      text: "Esportivos",
                    ),
                    Tab(
                      text: "Luxo",
                    ),
                  ],
                )),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarrosListView(
            tipo: CarroApi.classicos,
          ),
          CarrosListView(
            tipo: CarroApi.esportivos,
          ),
          CarrosListView(
            tipo: CarroApi.luxo,
          )
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
