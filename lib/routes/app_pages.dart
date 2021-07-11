import 'package:get/get_navigation/get_navigation.dart';
import 'package:to_do/features/todo/presentation/getx/pages/home_page_getx.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => HomePageGetx(),
    ),
    // GetPage(
    //   name: Routes.DETAILS,
    //   page: () => DetailsPage(),
    //   binding: DetailsBinding(),
    // ), //dependencias de details via rota
  ];
}
