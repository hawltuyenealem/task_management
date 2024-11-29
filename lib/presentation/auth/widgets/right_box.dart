import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/core/utils/color_constant.dart';

Container rightBox() {
  return Container(
    padding: const EdgeInsets.all(15),
    height: 90,
    width: 90,
    decoration: BoxDecoration(
      color: ColorConstant.primaryColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Center(
      child: Icon(Icons.check,weight: 80 ,size: 60,color: Colors.white,),
    ),
  );
}
