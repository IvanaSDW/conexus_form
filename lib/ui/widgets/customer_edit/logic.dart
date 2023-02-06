import 'package:conexus_form/ui/widgets/customer_detail_card/view.dart';
import 'package:conexus_form/utils/db_names.dart';
import 'package:conexus_form/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/firebase_crud.dart';
import '../../../core/services/response.dart';
import '../../../utils/constants.dart';
import '../../pages/home/logic.dart';

class CustomerEditLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  HomeLogic homeController = Get.find<HomeLogic>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _status = Rx<RxStatus>(RxStatus.empty());

  RxStatus get status => _status.value;

  bool _isValid() {
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
        Map<String, dynamic> newCustomerData =
        {
          CUSTOMER_FIRST_NAME_CN: firstNameController.text,
          CUSTOMER_LAST_NAME_CN: lastNameController.text,
          CUSTOMER_EMAIL_CN: emailController.text,
          CUSTOMER_PHONE_CN: phoneController.text,
        };
        FirebaseResponse response =
            await CustomerCrud().editCustomer(customerId: homeController.getCurrentCustomer!.id, newData: newCustomerData);
        if (response.code == 200) {
          _status.value = RxStatus.success();
          initForm();
          Get.snackbar('Success', response.message!,
              icon: const Icon(Icons.check_circle_outline));
          homeController.showWidget = 'detail_card';
        } else {
          Get.snackbar('Error :(', response.message!, icon: const Icon(Icons.error));
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
    homeController.showWidget = 'detail_card';
  }

  void initForm() {
    firstNameController.text = homeController.getCurrentCustomer!.firstName;
    lastNameController.text = homeController.getCurrentCustomer!.lastName;
    emailController.text = homeController.getCurrentCustomer!.email;
    phoneController.text = homeController.getCurrentCustomer!.phone;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }
}
