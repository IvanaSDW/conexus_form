import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MTextFormFieldComponent extends StatelessWidget {
  final logic = Get.find<MTextFormFieldLogic>();

  final String hintText = '';
  final Function validator = () {};
  final Function onSaved = () {};
  final bool isPassword = false;
  final bool isEmail = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
