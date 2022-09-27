import 'package:flutter/material.dart';
import 'MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Product Buy App',
        /*theme: ThemeData(
          primarySwatch: Colors.blue,
        ),*/
        home: MainScreen());
  }
}