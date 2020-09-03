import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clothing Brand',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[800],
        ),
        home: HomeScreen(),
      ),
    );
  }
}