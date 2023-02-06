import 'package:conexus_form/ui/widgets/customer_edit/logic.dart';
import 'package:conexus_form/ui/widgets/customer_edit/view.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => CustomerEditLogic());
  }
}
