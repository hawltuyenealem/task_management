import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/data/services/auth_service.dart';

abstract class AuthRepository {
  Future<Either<String,User?>> login({required String email, required String password});

  Future<Either<String,User?>> signUp({required String email, required String password});

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<String,User?>> login({required String email, required String password}) async {
    var response  = await authService.login(email: email, password: password);
    return response.fold((error)=>Left(error), (user)=>Right(user));
  }

  @override
  Future<void> signOut() async {
    return signOut();
  }

  @override
  Future<Either<String,User?>> signUp({required String email, required String password}) async {
    var response = await authService.signUp(email: email, password: password);
    return response.fold((error)=>Left(error), (user)=>Right(user));
  }
}
