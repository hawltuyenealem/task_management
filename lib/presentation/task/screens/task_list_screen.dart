import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/utils/color_constant.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/presentation/task/screens/add_task_screen.dart';
import 'package:task_management/presentation/task/widgets/header.dart';

import '../../../injection.dart';
import '../blocs/task_bloc.dart';
import '../widgets/task_section.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(LoadTasksEvent());
    // sl<TaskBloc>().add(LoadTasksEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoadingState) {
                  return const Column(
                    children: [
                      SizedBox(height: 150,),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (state is TaskLoadedState) {
        
                  final todayTasks =
                      state.tasks.where((task) => task.isToday()).toList();
                  final tomorrowTasks =
                      state.tasks.where((task) => task.isTomorrow()).toList();
                  final thisWeekTasks =
                      state.tasks.where((task) => task.isThisWeek()).toList();
        
                  if (todayTasks.isEmpty && tomorrowTasks.isEmpty && thisWeekTasks.isEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 150,),
                        Center(
                          child: Text(
                            "No tasks available",
                            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    );
                  }
        
        
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                          /// Today's Tasks
                        taskSection(context: context,title: "Today",tasks:todayTasks),
                        const SizedBox(height: 30),
        
                          /// Tomorrow
                        taskSection(context: context,title: "Tomorrow", tasks: tomorrowTasks),
                        const SizedBox(height: 30),
        
                           /// This Week's Tasks
                        taskSection(context: context,title: "This Week",tasks: thisWeekTasks),
                      ],
                    ),
                  );
                } else if (state is TaskErrorState) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Failed to load tasks!",
                        style: GoogleFonts.inter(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left-side Icon
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.purple),
              onPressed: () {
                // Action for grid icon
              },
            ),
            const SizedBox(width: 40,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddTaskScreen()),
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                    Positioned(
                      bottom:13,
                      right: 12,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
            // Right-side Icon
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
              onPressed: () {
                // Action for menu icon
              },
            ),
          ],
        ),
      ),

    );
  }


}
