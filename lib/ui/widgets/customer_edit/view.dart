import 'package:conexus_form/ui/pages/home/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CustomerEditComponent extends StatelessWidget {
  final logic = Get.put<CustomerEditLogic>(CustomerEditLogic());
  HomeLogic homeController = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: logic.formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(homeController.currentCustomer!.id),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your first name',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your last name',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.phoneController,
                decoration: const InputDecoration(
                  labelText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                      onPressed: logic.onSubmit,
                      child: logic.status.isLoading
                          ? const Text('working...')
                          : const Text('Submit'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: logic.onCancel,
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
