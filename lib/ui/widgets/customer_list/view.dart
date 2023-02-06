import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conexus_form/core/models/Customer.dart';
import 'package:conexus_form/ui/pages/home/logic.dart';
import 'package:conexus_form/ui/widgets/customer_list_item/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomerListComponent extends StatelessWidget {
  HomeLogic controller = Get.find<HomeLogic>();
  Stream<QuerySnapshot<Customer>> customerStream;

  CustomerListComponent({super.key, required this.customerStream});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Customer>>(
            stream: customerStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SpinKitSpinningLines(
                    color: Colors.blue,
                  ),
                );
              } else {
                return ListView(
                    children: snapshot.data!.docs.map((customer) {
                  return InkWell(
                    onTap: () => controller.onTapCustomer(customer.data()),
                    child: CustomerListItemComponent(
                        id: customer.data().id,
                        firstName: customer.data().firstName,
                        lastname: customer.data().lastName),
                  );
                }).toList());
              }
            }),
      ),
    );
  }
}
