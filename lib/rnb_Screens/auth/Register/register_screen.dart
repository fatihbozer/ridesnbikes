import 'package:flutter/material.dart';
import 'package:rides_n_bikes/helper/helper_functions.dart';
import 'package:rides_n_bikes/rnb_Screens/HomeScreen/Home/mainfeed.dart';
import 'package:rides_n_bikes/methods/auth_methods.dart';
import 'package:rides_n_bikes/rnb_Screens/Auth/Login/login_screen.dart';
import 'package:rides_n_bikes/rnb_Widgets/Buttons/rl_button.dart';
import 'package:rides_n_bikes/rnb_Widgets/TextField/rides_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwController = TextEditingController();
  bool _isLoading = false;

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // Aufruf der Funktion zur Benutzerregistrierung
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      confirmPw: confirmPwController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      // Zeigt die Fehlermeldung an, falls das Registrieren nicht erfolgreich war
      displayMessageToUser(res, context);
    } else {
      // Navigiert zur MainFeedPage nach erfolgreicher Registrierung
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainFeedPage()), (route) => false);
    }
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
                      MyTextField(hintText: "Username", obscureText: false, controller: usernameController),
                      const SizedBox(height: 16),
                      MyTextField(hintText: "E-Mail", obscureText: false, controller: emailController),
                      const SizedBox(height: 16),
                      MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
                      const SizedBox(height: 16),
                      MyTextField(hintText: "Confirm Password", obscureText: true, controller: confirmPwController),
                      const SizedBox(height: 32),
                      MyRLButton(text: 'Register', onTap: signUpUser),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?  '),
                          GestureDetector(
                            onTap: () {
                              // Navigiert zur LoginPage bei Klick auf "Login here"
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
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
