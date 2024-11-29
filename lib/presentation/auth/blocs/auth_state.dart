part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginLoading extends AuthState{}

class LoginDone extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError({required this.message});
}

class SignupLoading extends AuthState{}
class SignupDone extends AuthState {}

class SignupError extends AuthState {
  final String message;

  SignupError({required this.message});
}

class SignOutLoading extends AuthState{}
class SignOutDone extends AuthState {}

class SignOutError extends AuthState {
  final String message;

  SignOutError({required this.message});
}
