part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel task;

  UpdateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
