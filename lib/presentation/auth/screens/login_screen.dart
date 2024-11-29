import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/button_style.dart';
import 'package:task_management/core/utils/color_constant.dart';
import 'package:task_management/presentation/auth/screens/register_screen.dart';
import 'package:task_management/presentation/auth/widgets/login_options.dart';
import 'package:task_management/presentation/auth/widgets/right_box.dart';
import 'package:task_management/presentation/auth/widgets/text_formfiled.dart';
import 'package:task_management/presentation/common/screens/bottom_navigation_screen.dart';
import 'package:task_management/presentation/task/screens/task_list_screen.dart';

import '../../../injection.dart';
import '../../common/widgets/snackbar.dart';
import '../blocs/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginDone) {
            showSnackBar("Login Successfully", context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TaskListScreen()));
          }
          if (state is LoginError) {
            showSnackBar("Error while login", context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                rightBox(),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Welcome back!",
                  style: GoogleFonts.inter(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EMAIL ADDRESS",
                      style: GoogleFonts.inter(color: Colors.black54),
                    ),
                    AppTextField(
                      controller: emailController,
                      isEmail: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PASSWORD",
                          style: GoogleFonts.inter(color: Colors.black54),
                        ),
                        Text(
                          "Forgot Password?",
                          style: GoogleFonts.inter(
                              color: ColorConstant.primaryColor),
                        ),
                      ],
                    ),
                    AppTextField(
                      controller: passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showSnackBar("Fill the required fields", context);
                          } else {
                            sl<AuthBloc>().add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        style: flatButtonStyle,
                        child: Text('Log in',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16),))),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'or log in with',
                  style: GoogleFonts.inter(color: ColorConstant.primaryColor),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      loginOption(
                        icon: const FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                        ),
                        onPress: () {},
                        backgroundColor: ColorConstant.facebookColor,
                      ),
                      loginOption(
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          onPress: () {},
                          backgroundColor: ColorConstant.secondaryColor),
                      loginOption(
                          icon: const FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.white,
                          ),
                          onPress: () {},
                          backgroundColor: ColorConstant.iphoneColor),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.inter(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                        },
                        child: Text(
                          "Get started!",
                          style: GoogleFonts.inter(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
