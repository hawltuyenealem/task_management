part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {}

class TaskInitial extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

/// LOAD
class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;

  TaskLoadedState(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskErrorState extends TaskState {
  final String message;
  TaskErrorState(this.message);
  @override
  List<Object?> get props => [message];
}


/// ADD
class TaskAdded extends TaskState{
  @override
  List<Object?> get props => [];
}
class TaskAddError extends TaskState{
  final String message;

  TaskAddError({required this.message});

  @override
  List<Object?> get props => [message];
}


/// UPDATE
class TaskUpdated extends TaskState{
  @override
  List<Object?> get props => [];
}
class TaskUpdateError extends TaskState{
  final String message;

  TaskUpdateError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// DELETE
class TaskDeleted extends TaskState{
  @override
  List<Object?> get props => [];
}
class TaskDeleteError extends TaskState{
  final String message;

  TaskDeleteError({required this.message});

  @override
  List<Object?> get props => [message];
}
