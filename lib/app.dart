import 'package:flutter/material.dart';

import 'features/todo/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
