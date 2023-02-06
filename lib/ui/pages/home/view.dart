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
            return logic.showWidget == 'new_customer_form'
                ? SingleChildScrollView(child: CustomerFormComponent())
                : logic.showWidget == 'edit_customer_form'
                    ? SingleChildScrollView(child: CustomerEditComponent())
                    : Column(children: [
                        Card(
                          clipBehavior: Clip.none,
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                logic.searchString = value;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Buscar',
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: CustomerListComponent(
                                customerStream: logic.customerStream)),
                        logic.currentCustomer.value.email.trim().isNotEmpty
                            ? CustomerDetailCardComponent(
                                customer: logic.currentCustomer)
                            : const SizedBox.shrink()
                      ]);
          }),
        ),
        floatingActionButton: Obx(() {
          return Visibility(
            visible: logic.showWidget != 'new_customer_form',
            child: FloatingActionButton(
              onPressed: () => logic.onFab(),
              tooltip: 'Agregar un nuevo cliente',
              child: const Icon(Icons.add),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      );
    });
  }
}
