import 'package:get/get.dart';

import 'logic.dart';

class CustomerEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerEditLogic());
  }
}
