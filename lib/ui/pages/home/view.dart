import 'package:conexus_form/ui/widgets/customer_form/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(title: Text(logic.title),),
          body: Container(
            child: CustomerFormComponent(),
          ),
      );
    });
  }
}
