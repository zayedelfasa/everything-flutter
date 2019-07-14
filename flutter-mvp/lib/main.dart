import 'package:flutter/material.dart';
import 'package:login_with_sqflite/pages/home/home_page.dart';
import 'package:login_with_sqflite/pages/login/login_page.dart';

void main() {
  runApp(new MyApp());
}

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite App',
      routes: routes,
    );
  }
}