import 'package:flutter/material.dart';
import 'package:rides_n_bikes/rides_widgets/rides_button.dart';
import 'package:rides_n_bikes/rides_widgets/rides_textfield.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login() {}

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
              MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
              const SizedBox(height: 16),
              MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
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
              MyButton(text: 'Login', onTap: login),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account?  '),
                  GestureDetector(
                    onTap: () {},
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
