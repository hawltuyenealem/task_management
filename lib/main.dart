import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/presentation/common/screens/onboarding_screen.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';
import 'package:task_management/presentation/task/screens/task_list_screen.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCUVaW2boGtSwF11ZXIgaxBGLucR29UWkA",
        appId: "1:79545695017:android:b1b401162ef4e7e01f9538",
        messagingSenderId: "79545695017",
        projectId: "task-management-5d6d5"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_)=>sl<AuthBloc>()),
        BlocProvider<TaskBloc>(create: (_)=>sl<TaskBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const OnboardingScreen()
      ),
    );
  }
}


