import 'package:conexus_form/core/models/Customer.dart';
import 'package:conexus_form/ui/pages/home/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerDetailCardComponent extends StatelessWidget {
  HomeLogic homeController = Get.find<HomeLogic>();
  Customer customer;
  CustomerDetailCardComponent({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: customer.imageUrl != null
                      ? NetworkImage(customer.imageUrl!)
                      : null,
                  child: customer.imageUrl == null
                      ? Text(
                          customer.firstName[0].toUpperCase() + customer.lastName[0].toUpperCase(),
                          style: const TextStyle(fontSize: 36),
                        )
                      : null,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: Text(
                      '${customer.firstName} ${customer.lastName}',
                      style: const TextStyle(fontSize: 36),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Expanded(flex: 2, child: Text('ID: ')),
                  Expanded(flex: 8, child: Text(customer.id)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Expanded(flex: 2, child: Text('Email: ')),
                  Expanded(flex: 8, child: Text(customer.email)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Expanded(flex: 2, child: Text('Phone: ')),
                  Expanded(flex: 8, child: Text(customer.phone)),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(1, 1),
              heightFactor: 0.5,
              child: FloatingActionButton(
                mini: false,
                onPressed: () => homeController.onEditCustomer(),
                backgroundColor: Colors.white,
                child: Icon(Icons.edit, color: Colors.brown.shade800,),
              ),
            ),
            // Align(
            //   alignment: const Alignment(1.15, 0),
            //   heightFactor: 0.1,
            //   child: FloatingActionButton(
            //     mini: true,
            //     onPressed: () {  },
            //     backgroundColor: Colors.red,
            //     child: const Icon(Icons.delete),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
