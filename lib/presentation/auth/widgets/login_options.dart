import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Container loginOption({required Icon icon,required Color color}){
//   return Container(
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: color,
//       shape: BoxShape.circle
//     ),
//     child:icon,
//   );
// }

Widget loginOption({ required FaIcon icon,required void Function() onPress,required Color backgroundColor }){
  return CircleAvatar(
    radius: 30,
    backgroundColor: backgroundColor,
    child: IconButton(
      icon: icon,
      onPressed: onPress,
    ),
  );
}