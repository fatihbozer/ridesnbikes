import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/rides_widgets/my_button.dart';
import 'package:rides_n_bikes/rides_widgets/rides_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, width: 100, child: const Image(image: AssetImage('assets/icon/logo.png'))),
              const SizedBox(height: 32),
              const Text(
                "rides n' Bikes",
                style: TextStyle(fontFamily: 'Formula1bold', fontSize: 28),
              ),
              const SizedBox(height: 32),
              MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
              const SizedBox(height: 16),
              MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              MyButton(text: 'Login', onTap: login),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?  '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register here.',
                      style: TextStyle(fontFamily: 'Formula1bold'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
