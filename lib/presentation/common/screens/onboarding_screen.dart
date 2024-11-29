import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/utils/color_constant.dart';
import 'package:task_management/presentation/auth/widgets/right_box.dart';

import '../../auth/screens/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Center(child: rightBox()),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get things done.",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subtitle
                        Text(
                          "Just a click away from\nplanning your tasks.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.grey[300],
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.grey[300],
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: ColorConstant.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            // Bottom-right button and curved container
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(180.0),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(5)
                    ),
                    child: Container(
                      width: 200,
                      height: 200,
                      color: ColorConstant.primaryColor,
                    ),
                  ),

                  Positioned(
                    right: 30,
                    bottom: 40,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward,
                        color: Colors.white,
                        size: 60,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                      },
                      // Adjust the color as needed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
