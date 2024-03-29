import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/ProfilePic/default_profile_image.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/rl_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/TextField/rides_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

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
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayMessageToUser('Passwords dont match!', context);
    } else if (usernameController.text.length < 3 || usernameController.text.length > 20) {
      Navigator.pop(context);
      displayMessageToUser('Username must be between 3 and 20 characters long!', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

//test
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
        'name': usernameController.text,
        'bio': 'Hello, my name is ${usernameController.text} and I am new to this app.',
        'profileImageUrl': defaultProfileImageUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
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
                  MyTextField(hintText: "Username", obscureText: false, controller: usernameController),
                  const SizedBox(height: 16),
                  MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
                  const SizedBox(height: 16),
                  MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
                  const SizedBox(height: 16),
                  MyTextField(hintText: "Confirm Password", obscureText: true, controller: confirmPwController),
                  const SizedBox(height: 32),
                  MyRLButton(text: 'Register', onTap: registerUser),
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
        ],
      ),
    );
  }
}
