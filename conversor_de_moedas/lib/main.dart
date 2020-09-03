import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=057d130f";

void main () async{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
    )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar, euro;

  void _realChanged(String text){
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dollarChanged(String text){
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll (){
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch (snapshot.connectionState)
          {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              );
            default:
              if (snapshot.hasError)
              {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :(",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              else
              {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                
                return SingleChildScrollView(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150, color: Colors.amber,),
                      Divider(),
                      buildTextField("Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField("Dolar", "US\$", dollarController, _dollarChanged),
                      Divider(),
                      buildTextField("Euro", "€", euroController, _euroChanged),
                      Divider(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField (String label, String prefix, TextEditingController control, Function f) {
  return TextField(
    controller: control,
    decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: Colors.amber, fontSize: 20),
    border: OutlineInputBorder(),
    prefixText: prefix,
  ),
  onChanged: f,
  keyboardType: TextInputType.number,
  );
}