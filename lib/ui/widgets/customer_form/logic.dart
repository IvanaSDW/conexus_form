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
      Get.snackbar('Error en el ID!', 'Ingrese un  número de ID válido',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar('Error en el nombre!', 'Debe ingresar su nombre',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar('Error en el apellido!', 'Debe ingresar su apellido',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (!emailController.text.isValidEmail()) {
      Get.snackbar('Error en el email!', 'Ingrese una dirección de email válida!',
          icon: const Icon(Icons.error), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error en el número movil!', 'Debe ingresar su número móvil',
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
            id: idController.text.trim(),
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
          phone: phoneController.text.trim(),
        );
        FirebaseResponse response =
            await CustomerCrud().addCustomer(newCustomer);
        if (response.code == 200) {
          _status.value = RxStatus.success();
          resetForm();
          Get.snackbar('Operación exitosa', response.message!,
              icon: const Icon(Icons.check_circle_outline));
          homeController.showWidget = 'customer_list';
        } else {
          Get.snackbar('Error :(', response.message!, icon: const Icon(Icons.error));
          _status.value = RxStatus.error(response.message!);
        }
      } catch (e) {
        logger.e(e.toString());
        Get.snackbar('Error', e.toString(), icon: const Icon(Icons.error));
        _status.value = RxStatus.error(e.toString());
      }
    }
  }

  onCancel() {
    homeController.showWidget = 'none';
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
