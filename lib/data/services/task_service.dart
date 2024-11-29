import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, Unit>> createTask(
      {required String userId, required TaskModel taskData}) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(taskData.toJson());
      return const Right(unit);
    } catch (e) {
      return const Left('Failed to create tasks');
    }
  }

  Stream<Either<String, List<TaskModel>>> getTasks({
    required String userId,
    String? priority,
    bool? isCompleted,
  }) {
    try {
      Query query = _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .orderBy('dueDate', descending: false);

      if (priority != null) {
        query = query.where('priority', isEqualTo: priority);
      }

      if (isCompleted != null) {
        query = query.where('isCompleted', isEqualTo: isCompleted);
      }

      return query.snapshots().map(
            (snapshot) => Right<String, List<TaskModel>>(
          snapshot.docs.map((doc) {
            final data = doc.data()!;
            print("here we go data${data}");
            print("title ${doc['title']}");


            return TaskModel(
                id: doc.id,
                priority: doc['priority'],
                dueDate: DateTime.now(),
                description: doc['description'] ??"test description",
                title: doc['title'],
                isCompleted: doc['isCompleted']??false
            );
          }).toList(),
        ),
      ).handleError(
            (error) => const Left<String, List<TaskModel>>('Failed to fetch tasks'),
      );
    } catch (e) {
      return Stream.value(const Left('Failed to fetch tasks'));
    }
  }


  Future<Either<String, Unit>> updateTask({required String userId,required TaskModel updatedData,}) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(updatedData.id)
          .update(updatedData.toJson());
      return const Right(unit);
    } catch (e) {
      return const Left('Failed to update task');
    }
  }

  Future<Either<String, Unit>> deleteTask({required String userId, required String taskId}) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
      return const Right(unit);
    } catch (e) {
      return const Left('Failed to delete task');
    }
  }
}
