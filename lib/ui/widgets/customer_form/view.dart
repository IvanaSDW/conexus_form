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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: logic.idController,
                decoration: InputDecoration(
                  labelText: 'Enter Id',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.firstNameController,
                decoration: InputDecoration(
                  labelText: 'Enter your first name',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.lastNameController,
                decoration: InputDecoration(
                  labelText: 'Enter your last name',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: logic.emailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              FilledButton(
                onPressed: logic.onSubmit,
                child: logic.status.isLoading
                    ? Text('Loading...')
                    : logic.status.isSuccess
                        ? Text('Success')
                        : Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
