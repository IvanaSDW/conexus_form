import 'package:get/get.dart';

import 'logic.dart';

class CustomerListItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerListItemLogic());
  }
}
