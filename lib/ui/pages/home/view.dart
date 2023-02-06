import 'package:conexus_form/ui/widgets/customer_detail_card/view.dart';
import 'package:conexus_form/ui/widgets/customer_edit/view.dart';
import 'package:conexus_form/ui/widgets/customer_form/view.dart';
import 'package:conexus_form/ui/widgets/customer_list/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: Text(logic.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return Column(children: [
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      logic.searchString = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: CustomerListComponent(
                customerStream: logic.customerStream,
              )),
              logic.showBelow == 'detail_card'
                  ? CustomerDetailCardComponent(customer: logic.currentCustomer)
                  : logic.showBelow == 'new_customer_form'
                      ? CustomerFormComponent()
                      : logic.showBelow == 'edit_customer_form'
                          ? CustomerEditComponent()
                          : const SizedBox.shrink(),
            ]);
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => logic.onFab(),
          tooltip: 'Add new customer',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
    });
  }
}
