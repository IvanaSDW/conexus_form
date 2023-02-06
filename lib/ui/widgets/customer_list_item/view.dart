import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CustomerListItemComponent extends StatelessWidget {
  final logic = Get.put<CustomerListItemLogic>(CustomerListItemLogic());
  String id;
  String firstName;
  String lastname;

  CustomerListItemComponent(
      {super.key,
      required this.id,
      required this.firstName,
      required this.lastname});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(flex: 10, child: Text(id)),
            Expanded(flex: 10, child: Text(firstName)),
            Expanded(flex: 10, child: Text(lastname)),
          ],
        ),
      ),
    );
  }
}
