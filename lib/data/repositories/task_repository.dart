import 'package:dartz/dartz.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/task_service.dart';

abstract class TaskRepository {
  Future<Either<String, Unit>> createTask({required String userId, required TaskModel taskData});
  Stream<Either<String, List<TaskModel>>> getTasks({required String userId, String? priority,bool? isCompleted,});
  Future<Either<String, Unit>> updateTask({required String userId,required TaskModel updatedData,});
  Future<Either<String, Unit>> deleteTask({required String userId, required String taskId});
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskService taskService;

  TaskRepositoryImpl({required this.taskService});

  @override
  Future<Either<String, Unit>> createTask({required String userId, required TaskModel taskData}) async{
    var response = await taskService.createTask(userId: userId, taskData: taskData);
    return response.fold((error)=>Left(error), (success)=>Right(success));
  }

  @override
  Future<Either<String, Unit>> deleteTask({required String userId, required String taskId})async {
    var response  = await taskService.deleteTask(userId: userId, taskId: taskId);
    return response.fold((error)=>Left(error), (success)=>Right(success));
  }

  @override
  Stream<Either<String, List<TaskModel>>> getTasks({required String userId, String? priority,bool? isCompleted,}) {


    return taskService.getTasks(userId: userId,isCompleted: isCompleted,priority: priority).map((either) {
      return either.fold(
            (error) => Left(error),
            (tasks) => Right(tasks),
      );
    });
  }

  @override
  Future<Either<String, Unit>> updateTask({required String userId, required TaskModel updatedData}) async{
    var response = await taskService.updateTask(userId: userId, updatedData: updatedData);
    return response.fold((error)=>Left(error), (success)=>Right(success));
  }


}
