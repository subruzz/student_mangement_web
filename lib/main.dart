import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/firebase_options.dart';
import 'package:studentmanagement/screens/home_screen.dart';
import 'package:studentmanagement/screens/login_screen.dart';
import 'package:studentmanagement/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomeScreen(email: 'email');
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const LoginPage();
        },
      ),
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final message = await AuthService().login(
//                   email: _emailController.text,
//                   password: _passwordController.text,
//                 );
//                 if (message!.contains('Success')) {
//                   if (context.mounted) {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (context) => const Home(),
//                       ),
//                     );
//                   }
//                 }
//                 if (context.mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(message),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const CreateAccount(),
//                   ),
//                 );
//               },
//               child: const Text('Create Account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CreateAccount extends StatefulWidget {
//   const CreateAccount({super.key});

//   @override
//   State<CreateAccount> createState() => _CreateAccountState();
// }

// class _CreateAccountState extends State<CreateAccount> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Account'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final message = await AuthService().registration(
//                   email: _emailController.text,
//                   password: _passwordController.text,
//                 );
//                 if (message!.contains('Success')) {
//                   Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (context) => const Home()));
//                 }
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(message),
//                   ),
//                 );
//               },
//               child: const Text('Create Account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   const Home({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Succesfully signed'),
//     );
//   }
// }
