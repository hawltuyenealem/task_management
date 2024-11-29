import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_management/core/constants.dart';
import 'package:task_management/data/repositories/task_repository.dart';
import 'package:task_management/data/services/local_storage_service.dart';

import '../../../data/models/task_model.dart';
import '../../../injection.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<FilterTasksEvent>(_onFilterTasks);
    on<SortTasksByDueDateEvent>(_onSortTasksByDueDate);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }


  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      String userId = await sl<LocalStorageService>().getStringFromDisk('userId') ?? "userId";

      await emit.forEach<Either<String, List<TaskModel>>>(
        taskRepository.getTasks(userId: userId),
        onData: (either) => either.fold(
              (failure) => TaskErrorState(failure),
              (tasks) => TaskLoadedState(tasks),
        ),
        onError: (error, stackTrace) {
          return TaskErrorState("An unexpected error occurred: $error");
        },
      );
    } catch (error) {
      emit(TaskErrorState("Failed to load tasks: $error"));
    }
  }



  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      String userId = await sl<LocalStorageService>().getStringFromDisk('userId') ?? "userId";
      final response = await taskRepository.createTask(userId: userId, taskData: event.task);
      response.fold(
            (failure) => emit(TaskAddError(message: failure)),
            (_) => emit(TaskAdded()),
      );
    } catch (error) {
      emit(TaskAddError(message: "An error occurred while adding the task: $error"));
    }
  }


  Future<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      String userId = await sl<LocalStorageService>().getStringFromDisk('userId') ?? "defaultUserId";

      final response = await taskRepository.updateTask(
        userId: userId,
        updatedData: event.task,
      );

      response.fold(
            (failure) => emit(TaskUpdateError(message: failure)),
            (_) => emit(TaskUpdated()),
      );
    } catch (error) {
      emit(TaskUpdateError(message: "An error occurred while updating the task: $error"));
    }
  }


  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      String userId = await sl<LocalStorageService>().getStringFromDisk('userId') ?? "defaultUserId";

      final response = await taskRepository.deleteTask(userId: userId, taskId: event.taskId);

      response.fold(
            (failure) => emit(TaskDeleteError(message: failure)),
            (_) => emit(TaskDeleted()),
      );
    } catch (error) {
      emit(TaskDeleteError(message: "An error occurred while deleting the task: $error"));
    }
  }

  Future<void> _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      String userId = await sl<LocalStorageService>().getStringFromDisk('userId') ?? "defaultUserId";
      final tasksStream = taskRepository.getTasks(
        userId: userId,
        priority: event.priority,
        isCompleted: event.isCompleted,
      );

      await emit.forEach<Either<String, List<TaskModel>>>(
        tasksStream,
        onData: (either) => either.fold(
              (failure) => TaskErrorState(failure),
              (filteredTasks) => TaskLoadedState(filteredTasks),
        ),
        onError: (error, stackTrace) {
          return TaskErrorState("An error occurred");
        },
      );
    } catch (error) {
      emit(TaskErrorState("Failed to filter tasks"));
    }
  }


  Future<void> _onSortTasksByDueDate(SortTasksByDueDateEvent event, Emitter<TaskState> emit) async {
    if (state is TaskLoadedState) {
      final currentState = state as TaskLoadedState;

      final sortedTasks = List<TaskModel>.from(currentState.tasks)
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      emit(TaskLoadedState(sortedTasks));
    }
  }

}

