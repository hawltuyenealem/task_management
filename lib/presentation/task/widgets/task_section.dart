import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';
import 'package:task_management/presentation/task/widgets/task_card.dart';

import '../../../core/utils/color_constant.dart';
import '../../../data/models/task_model.dart';
import '../../../injection.dart';
import '../screens/edit_task_screen.dart';
import 'dialogue.dart';

Widget taskSection(
    {required BuildContext context,
    required String title,
    required List<TaskModel> tasks}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.inter(
          color: ColorConstant.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      tasks.isEmpty
          ? Text(
              "No tasks available.",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
            )
          : Column(
              children: tasks
                  .map(
                    (task) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: taskCard(
                          task: task,
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTaskScreen(
                                  task: task,
                                  onSave: (updatedTask) {
                                    sl<TaskBloc>().add(UpdateTaskEvent(task: updatedTask));
                                  },
                                ),
                              ),
                            );
                          },
                          onDelete: () => showDeleteConfirmationDialog(
                                context: context,
                                taskTitle: task.title,
                                onConfirm: () {
                                  sl<TaskBloc>()
                                      .add(DeleteTaskEvent(taskId: task.id));
                                },
                              )),
                    ),
                  )
                  .toList(),
            ),
    ],
  );
}
