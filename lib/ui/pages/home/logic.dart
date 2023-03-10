import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexus_form/ui/widgets/customer_edit/logic.dart';
import 'package:conexus_form/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/models/Customer.dart';
import '../../../core/services/firebase_crud.dart';
import '../../../core/services/response.dart';

class HomeLogic extends GetxController {
  String title = 'Conexus IT - Gestión de Clientes';

  final RxString _searchString = ''.obs;
  String get searchString => _searchString.value;
  set searchString(value) => _searchString.value = value;

  late Stream<QuerySnapshot<Customer>> customerStream;
  final Rx<Customer> currentCustomer = Rx<Customer>(Customer.empty());
  Customer? get getCurrentCustomer => currentCustomer.value;
  set setCurrentCustomer(Customer value) => currentCustomer.value = value;

  final RxString _showBelow = 'customer_list'.obs;
  String get showWidget => _showBelow.value;
  set showWidget(String value) => _showBelow.value = value;

  final _deleteStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get deleteStatus => _deleteStatus.value;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  bool matchSearchString (Customer customer) {
    return customer.id.toLowerCase().contains(searchString.toLowerCase()) ||
    customer.firstName.toLowerCase().contains(searchString.toLowerCase()) ||
    customer.lastName.toLowerCase().contains(searchString.toLowerCase()) ||
    customer.email.toLowerCase().contains(searchString.toLowerCase());
  }

  onTapCustomer(Customer customer) {
    setCurrentCustomer = customer;
    showWidget = 'detail_card';
    Get.find<CustomerEditLogic>().initForm();
  }

  onFab() {
    showWidget = 'new_customer_form';
  }

  onEditCustomer() {
    showWidget = 'edit_customer_form';
  }

  onDeleteTapped() {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirma el borrado...'),
        content: const Text('Este cliente se borrará de manera permanete!'),
        actions: [
          TextButton(onPressed: onDeleteCustomer, child: const Text('Borrar')),
          TextButton(onPressed: Get.back, child: const Text('Cancelar'))
        ],
      )
    );
  }
  
  onDeleteCustomer() async {
    _deleteStatus.value = RxStatus.loading();
    Get.back();
    try {
      // save data to database;
      FirebaseResponse response =
          await CustomerCrud().deleteCustomer(getCurrentCustomer!.id);
      if (response.code == 200) {
        _deleteStatus.value = RxStatus.success();
        Get.snackbar('Operación exitosa', response.message!,
            icon: const Icon(Icons.check_circle_outline));
        showWidget = 'customer_list';
        currentCustomer.value = Customer.empty();
      } else {
        Get.snackbar('Error :(', response.message!, icon: const Icon(Icons.error));
        _deleteStatus.value = RxStatus.error(response.message!);
      }
    } catch (e) {
      logger.e(e.toString());
      Get.snackbar('Error', e.toString(), icon: const Icon(Icons.error));
      _deleteStatus.value = RxStatus.error(e.toString());
    }
  }

  void loadCustomers() async {
    customerStream = CustomerCrud().fetchCustomers();
  }
}
