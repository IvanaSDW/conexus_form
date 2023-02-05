import 'package:get/get.dart';

import 'logic.dart';

class MTextFormFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MTextFormFieldLogic());
  }
}
