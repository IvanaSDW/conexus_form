import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexus_form/utils/constants.dart';
import 'package:get/get.dart';

import '../../../core/models/Customer.dart';
import '../../../core/services/firebase_crud.dart';

class HomeLogic extends GetxController {
  String title = 'Conexus IT - Customer Management';

  late Stream<QuerySnapshot<Customer>> customerStream;
  final Rx<Customer?> _currentCustomer = Rx<Customer?>(null);
  Customer? get currentCustomer => _currentCustomer.value;
  set currentCustomer(Customer? value) => _currentCustomer.value = value;

  final RxString _showBelow = 'none'.obs;
  String get showBelow => _showBelow.value;
  set showBelow(String value) => _showBelow.value = value;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  onTapCustomer(Customer customer) {
    currentCustomer = customer;
    showBelow = 'detail_card';
  }

  onFab() {
    showBelow = 'new_customer_form';
  }

  onEditCustomer() {
    logger.i('called');
    showBelow = 'edit_customer_form';
  }

  void loadCustomers() async {
    customerStream = CustomerCrud().fetchCustomers();
  }
}
