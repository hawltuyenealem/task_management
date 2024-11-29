import 'package:flutter/material.dart';
import 'package:task_management/core/utils/color_constant.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50),
  shadowColor: Colors.grey,

  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0),),
  ),
  backgroundColor: ColorConstant.primaryColor,
);