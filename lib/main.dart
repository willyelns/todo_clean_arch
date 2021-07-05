import 'package:flutter/material.dart';

import 'app.dart';

import './injection_container.dart' as dependecy_injection;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dependecy_injection.init();
  runApp(App());
}
