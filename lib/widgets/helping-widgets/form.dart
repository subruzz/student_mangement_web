import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/forgot_password.dart';
import 'package:studentmanagement/services/auth_service.dart';
import 'package:studentmanagement/screens/home_screen.dart';
import 'package:studentmanagement/screens/signup_screen.dart';
import 'package:studentmanagement/screens/login_screen.dart';
import 'package:studentmanagement/widgets/helping-widgets/auth_button.dart';
import 'package:studentmanagement/widgets/helping-widgets/auth_toggle.dart';
import 'package:studentmanagement/widgets/helping-widgets/auth_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.type});
  final String type;
  @override
  State<LoginForm> createState() => _MyTextfieldsState();
}

class _MyTextfieldsState extends State<LoginForm> {
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupUsernameController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    final String res = await AuthServices.signupUser(
        email: _signupEmailController.text.trim(),
        password: _signupPasswordController.text.trim(),
        username: _signupUsernameController.text.trim(),
        createdAt: DateTime.now(),
        // image: _pickedImage!,
        status: 1);
    if (res != 'success') {
      showSnackBar(res);
    } else {
      goToHomeScreen();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthServices.loginUser(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim());
    if (res != 'success') {
      showSnackBar(res);
    } else {
      goToHomeScreen();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: const EdgeInsets.all(10),
        elevation: 4,
        backgroundColor: Colors.red,
        content: Text(
          msg.split(']').last,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: widget.type == 'd'
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.type != 'login')
            LoginTextfields(
                icon: Icons.person_2_rounded,
                controller: _signupUsernameController,
                fieldName: 'username'),
          const SizedBox(
            height: 20,
          ),
          LoginTextfields(
              icon: Icons.email,
              controller: widget.type == 'login'
                  ? _loginEmailController
                  : _signupEmailController,
              fieldName: 'E-mail'),
          const SizedBox(
            height: 20,
          ),
          LoginTextfields(
              icon: Icons.password,
              controller: widget.type == 'login'
                  ? _loginPasswordController
                  : _signupPasswordController,
              fieldName: 'password'),
          const SizedBox(
            height: 10,
          ),
          if (widget.type == 'login')
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>const  ForgotPasswordPage()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                )),
          const SizedBox(
            height: 10,
          ),
          AuthButton(
              isLoading: _isLoading,
              text: widget.type == 'login' ? 'Log In' : 'Sign Up',
              authCheck: widget.type == 'login'
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                      }
                    }
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        _registerUser();
                      }
                    }),
          const SizedBox(
            height: 10,
          ),
          AuthScreenToggle(
              toggleAuthScreen: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.type != 'login'
                          ? const LoginPage()
                          : const SignupPage(),
                    ));
              },
              text1: widget.type == 'login'
                  ? 'Don\'t Have an account?'
                  : 'Already Have an account?',
              text2: widget.type == 'login' ? 'Register' : 'login')
        ],
      ),
    );
  }
}
