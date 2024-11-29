import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/utils/color_constant.dart';
import 'package:task_management/core/utils/dateFormatter.dart';

import '../../../data/models/task_model.dart';

Widget taskCard({
  required TaskModel task,
  required Function() onDelete, // Callback for deleting
  required Function() onEdit,   // Callback for editing
}) {

  return Dismissible(
    key: Key(task.id),
    direction: DismissDirection.endToStart,
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    onDismissed: (direction) {
      onDelete();
    },
    child: ListTile(
      leading: Icon(Icons.circle,color: ColorConstant.primaryColor,),
      tileColor: Colors.white,
      title: Text(
        task.title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: task.isCompleted ? Colors.grey : Colors.black,
          decoration:
          task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        formatDate(task.dueDate),
        style: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: onEdit,
      ),
    ),
  );
}
