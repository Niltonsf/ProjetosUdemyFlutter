import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields ()
  {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcular ()
  {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      
      if (imc < 18.6)
      {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 18.6 && imc < 24.9)
      {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 24.9 && imc < 29.9)
      {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 29.9 && imc < 34.9)
      {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 34.9 && imc < 39.9)
      {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 40)
      {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: (){
              _resetFields();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0 , 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 120,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Seu Peso (KG)",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: pesoController,
                  validator: (pesoController){
                    if (pesoController.isEmpty)
                    {
                      return "Insira seu peso!";
                    }
                  },
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Sua Altura (cm)",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
                controller: alturaController,
                validator: (alturaController) {
                    if (alturaController.isEmpty)
                    {
                      return "Insira sua altura!";
                    }
                  },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 90, right: 90),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        calcular();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.purple,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 30),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}