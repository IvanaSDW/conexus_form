import 'package:conexus_form/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerFormLogic extends GetxController {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final _status = Rx<RxStatus>(RxStatus.empty());

  RxStatus get status => _status.value;

  bool _isValid() {
    if (idController.text.trim().isEmpty) {
      Get.snackbar('Error in ID!', 'Enter a valid ID number',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar('Error in first name!', 'You need to enter your first name',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar('Error in last name!', 'You need to enter your last name',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error in email!', 'Enter a valid email address',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  Future<void> onSubmit() async {
    if (_isValid()) {
      _status.value = RxStatus.loading();
      try {
        // save data to database;
        _status.value = RxStatus.success();
      } catch (e) {
        logger.e(e.toString());
        Get.snackbar('title', e.toString());
        _status.value = RxStatus.error(e.toString());
      }
    }
  }

  @override
  void onClose() {
    idController.dispose();
    firstNameController.dispose();
    emailController.dispose();
  }
}
