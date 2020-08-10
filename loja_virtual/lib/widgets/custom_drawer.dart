import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageControler;

  CustomDrawer(this.pageControler);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    Widget _drawerContent() => ListView(
      padding: EdgeInsets.only(left: 32.0),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
          height: 170.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10.0,
                left: 0.0,
                child: Text(
                  "Flutter's\nBrand",
                  style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                left: 0.0,
                bottom: 0.0,
                child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Olá, ${!model.isLoggedIn() ? '' : model.userData['name']}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        GestureDetector(
                          child: Text(
                            !model.isLoggedIn() ? "Entre ou cadastre-se >" : 'Sair', 
                            style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                            ),
                          ),
                          onTap: (){
                            if(!model.isLoggedIn()){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                            }
                            else {
                              model.signOut();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(),
        DrawerTile(Icons.home, "Início", pageControler, 0),
        DrawerTile(Icons.list, "Produtos", pageControler, 1),
        DrawerTile(Icons.location_on, "Lojas", pageControler, 2),
        DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageControler, 3),
      ],
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          _drawerContent(),
        ],
      ),
    );
  }
}