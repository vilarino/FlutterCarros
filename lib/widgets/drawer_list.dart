import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot){
                Usuario usuario = snapshot.data;
                return usuario != null ? _header(usuario) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario usuario) {
    return UserAccountsDrawerHeader(
            accountName: Text(usuario.nome),
            accountEmail: Text(usuario.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(usuario.urlFoto),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
