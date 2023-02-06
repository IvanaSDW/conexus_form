import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CustomerFormComponent extends StatelessWidget {
  static CustomerFormLogic logic = Get.put(CustomerFormLogic());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: logic.formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: logic.idController,
                decoration: const InputDecoration(
                  labelText: 'Enter Id',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
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
