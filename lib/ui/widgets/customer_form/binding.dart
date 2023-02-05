import 'package:get/get.dart';

import 'logic.dart';

class CustomerFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerFormLogic());
  }
}
