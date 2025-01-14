import 'package:flutter/material.dart';
import 'package:studentmanagement/widgets/helping-widgets/form.dart';
import 'package:studentmanagement/widgets/helping-widgets/signup_image.dart';
import 'package:studentmanagement/widgets/helping-widgets/welcome_text.dart';

class WebScreenSignup extends StatelessWidget {
  const WebScreenSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          Row(
            children: [
              // Left side - 50% white background
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.grey,
              ),
              // Right side - 50% blue background
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.blue,
              ),
            ],
          ),
          // Overlay card
          Positioned(
            top: 50,
            left: 50,
            bottom: 50,
            right: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(40),
                      child: const SingleChildScrollView(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              WelcomeText(
                                type: 'd',
                                text1: 'Welcome, New User!\n',
                                text2:
                                    'Start exploring our app and discover amazing features!',
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              LoginForm(type: 'type')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.white54,
                        ),
                        child: const SignUpImage(
                          image: 'assets/images/signup_image.json',
                          height: double.infinity,
                          width: double.infinity,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
