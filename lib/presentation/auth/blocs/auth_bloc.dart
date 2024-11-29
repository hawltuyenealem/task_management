import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/data/repositories/auth_repository.dart';

import '../../../data/services/local_storage_service.dart';
import '../../../injection.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoading());

    var response = await authRepository.login(
        email: event.email, password: event.password);

    response
        .fold((error) => emit(LoginError(message: error)),
            (user) async {
          emit(LoginDone());
          sl<LocalStorageService>().saveStringToDisk('userId', user!.uid);
          // sl<LocalStorageService>().save('user', user);
          sl<LocalStorageService>().saveBooleanToDisk("login", true);
        });
  }

  void _onSignUp(SignupEvent event, Emitter<AuthState> emit) async {
    emit(SignupLoading());
    var response = await authRepository.signUp(
        email: event.email, password: event.password);
    response.fold((error) => emit(SignupError(message: error)),
            (user) => emit(SignupDone()));
  }

  void _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(SignOutLoading());
    try {
      var response = authRepository.signOut();
      emit(SignupDone());
    } catch (e) {
      emit(SignupError(message: "Failed to load tasks"));
    }
  }
}
