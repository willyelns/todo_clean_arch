import 'package:flutter/material.dart';

import './injection_container.dart' as dependecy_injection;
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dependecy_injection.init();
  runApp(const App());
}
