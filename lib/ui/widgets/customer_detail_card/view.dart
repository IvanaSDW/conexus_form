import 'package:conexus_form/core/models/Customer.dart';
import 'package:conexus_form/ui/pages/home/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomerDetailCardComponent extends StatelessWidget {
  final HomeLogic homeController = Get.find<HomeLogic>();
  final Rx<Customer> customer;

  CustomerDetailCardComponent({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() {
              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.brown.shade800,
                        backgroundImage: customer.value.imageUrl != null
                            ? NetworkImage(customer.value.imageUrl!)
                            : null,
                        child: customer.value.imageUrl == null
                            ? Text(
                          customer.value.firstName[0].toUpperCase() +
                              customer.value.lastName[0].toUpperCase(),
                          style: const TextStyle(fontSize: 36),
                        )
                            : null,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 8.0),
                          child: Text(
                            '${customer.value.firstName} ${customer.value.lastName}',
                            style: const TextStyle(fontSize: 36),
                            maxLines: 2,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: Text('ID: ')),
                        Expanded(flex: 8, child: Text(customer.value.id)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: Text('Email: ')),
                        Expanded(flex: 8, child: Text(customer.value.email)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: Text('Phone: ')),
                        Expanded(flex: 8, child: Text(customer.value.phone)),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: FloatingActionButton(
              mini: false,
              onPressed: () => homeController.onEditCustomer(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                color: Colors.brown.shade800,
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: FloatingActionButton(
              mini: true,
              onPressed: () => homeController.onDeleteTapped(),
              backgroundColor: Colors.red,
              child: homeController.deleteStatus == RxStatus.loading()
                  ? SpinKitChasingDots(
                size: 12,
              )
                  : const Icon(Icons.delete),
            ),
          )
        ],
      ),
    );
  }
}
