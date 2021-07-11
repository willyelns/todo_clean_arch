import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/features/todo/presentation/getx/pages/home_page_getx.dart';

import 'features/todo/presentation/getx/bindings/home_biding.dart';
import 'routes/app_pages.dart';

// import './injection_container.dart' as dependecy_injection;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // dependecy_injection.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: true,
    initialRoute: Routes.INITIAL,
    initialBinding: HomeBinding(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: HomePageGetx(),
    locale: Locale('pt', 'BR'),
    // translationsKeys:
    //     AppTranslation.translations,
  ));
}
