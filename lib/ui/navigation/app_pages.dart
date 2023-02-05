import 'package:conexus_form/ui/navigation/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home/binding.dart';
import '../pages/home/view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
