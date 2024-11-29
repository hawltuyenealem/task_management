import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/utils/color_constant.dart';
import 'package:task_management/core/utils/dateFormatter.dart';

Widget header(){
  return Container(
    height: 180,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: ColorConstant.primaryColor
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30,),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,

              ),
              child: const Icon(CupertinoIcons.square_grid_2x2),
            ),
            SizedBox(width: 10,),
           Flexible(child:  TextFormField(
             decoration: const InputDecoration(
               fillColor: Colors.white,
               filled: true,
               contentPadding: EdgeInsets.all(0),
               prefixIcon: Icon(CupertinoIcons.search),
               border: OutlineInputBorder(borderSide: BorderSide(
                 color: Colors.white
               ),
                 borderRadius: BorderRadius.all(Radius.circular(15)),
               ),
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.white),
                 borderRadius: BorderRadius.all(Radius.circular(15)),
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(15)),
               ),
             ),
           ),),
            SizedBox(width: 10,),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,

              ),
              child: const Icon(Icons.more_horiz,color: Colors.white,),
            ),
          ],
        ),
        const SizedBox(height: 18,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today, ${formatDate(DateTime.now())}",style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),),
            Text("My Tasks",style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),)
          ],
        )
      ],
    ),
  );
}