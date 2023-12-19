import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/rides_widgets/rides_button.dart';
import 'package:rides_n_bikes/rides_widgets/rides_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPwController = TextEditingController();

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayMessageToUser('Passwords dont match!', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
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
              Container(
                height: 80,
                width: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 32),
              const Text(
                "rides n' Bikes",
                style: TextStyle(fontFamily: 'Formula1bold', fontSize: 28),
              ),
              const SizedBox(height: 32),
              MyTextField(hintText: "Username", obscureText: false, controller: usernameController),
              const SizedBox(height: 16),
              MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
              const SizedBox(height: 16),
              MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
              const SizedBox(height: 16),
              MyTextField(hintText: "Confirm Password", obscureText: true, controller: confirmPwController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              MyButton(text: 'Register', onTap: registerUser),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?  '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login here.',
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
