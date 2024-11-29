import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/presentation/auth/screens/login_screen.dart';
import 'package:task_management/presentation/common/widgets/snackbar.dart';

import '../../../core/button_style.dart';
import '../../../core/utils/color_constant.dart';
import '../../../injection.dart';
import '../widgets/login_options.dart';
import '../widgets/right_box.dart';
import '../widgets/text_formfiled.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignupDone) {
            showSnackBar("Register Successfully", context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
          if (state is SignupError) {
            showSnackBar("Error while registering", context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
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
                  "Let's get started!",
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
                      height: 10,
                    ),
                    Text(
                      "PASSWORD",
                      style: GoogleFonts.inter(color: Colors.black54),
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
                            sl<AuthBloc>().add(SignupEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        style: flatButtonStyle,
                        child: Text('Sign up',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16)))),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'or sign up with',
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Already have an account?",
                          style: GoogleFonts.inter(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          "Log in",
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
