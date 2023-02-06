import 'package:conexus_form/core/models/Customer.dart';
import 'package:conexus_form/core/services/firebase_crud.dart';
import 'package:conexus_form/core/services/response.dart';
import 'package:conexus_form/ui/pages/home/logic.dart';
import 'package:conexus_form/utils/constants.dart';
import 'package:conexus_form/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerFormLogic extends GetxController {
  final formKey = GlobalKey<FormState>();

  HomeLogic homeController = Get.find<HomeLogic>();

  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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
    if (!emailController.text.isValidEmail()) {
      Get.snackbar('Error in email!', 'Enter a valid email address',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error phone!', 'You need to enter your mobile phone number',
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
        Customer newCustomer = Customer(
            id: idController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
          phone: phoneController.text,
        );
        FirebaseResponse response =
            await CustomerCrud().addCustomer(newCustomer);
        if (response.code == 200) {
          _status.value = RxStatus.success();
          resetForm();
          Get.snackbar('Success', response.message!,
              icon: const Icon(Icons.check_circle_outline));
          homeController.showBelow = 'none';
        } else {
          Get.snackbar('Error :(', response.message!, icon: Icon(Icons.error));
          _status.value = RxStatus.error(response.message!);
        }
      } catch (e) {
        logger.e(e.toString());
        Get.snackbar('title', e.toString(), icon: const Icon(Icons.error));
        _status.value = RxStatus.error(e.toString());
      }
    }
  }

  onCancel() {
    homeController.showBelow = 'none';
  }

  void resetForm() {
    idController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
  }

  @override
  void onClose() {
    idController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }
}
