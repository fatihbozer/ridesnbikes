import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/mainfeed.dart';
import 'package:rides_n_bikes/resources/auth_methods.dart';
import 'package:rides_n_bikes/rnb_Screens/auth/Register/register_screen.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/rl_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/TextField/rides_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'success') {
      // Navigiert zur MainFeedPage nach erfolgreichem Login

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const MainFeedPage())));
    } else {
      // Zeigt die Fehlermeldung an, falls das Login nicht erfolgreich war

      displayMessageToUser(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100, width: 100, child: Image(image: AssetImage('assets/icon/logo.png'))),
                      const SizedBox(height: 32),
                      const Text(
                        "rides n' Bikes",
                        style: TextStyle(fontFamily: 'Formula1bold', fontSize: 28),
                      ),
                      const SizedBox(height: 32),
                      MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
                      const SizedBox(height: 16),
                      MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
                      /*

                       // FORGET PASSWORD FUNCTION

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),                          
                        ],
                      ),
                      */
                      const SizedBox(height: 32),
                      MyRLButton(text: 'Login', onTap: loginUser),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an account?  '),
                          GestureDetector(
                            onTap: () {
                              // Navigiert zur RegisterPage bei Klick auf "Register here"

                              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                            },
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
            ],
          ),
          if (_isLoading)
            Container(
              // Hintergrund für den Ladebildschirm
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
