import 'package:flutter/material.dart';
import 'package:to_do/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: routes,
    );
  }
}
