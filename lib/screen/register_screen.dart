import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/login_screen.dart';

import '../service/db_helper.dart';
import '../widget/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscure = true;

  registerInputHandler() {
    bool isFilled = true;
    if (usernameController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Username can\'t empty!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
      isFilled = false;
    } else if (passwordController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Password can\'t empty!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (confirmPasswordController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Confirm password can\'t empty!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Password less than 8 characters!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
      isFilled = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Confirm password must be same!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
      isFilled = false;
    }
    return isFilled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/newspaper.png',
                  height: 100,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Newspaper',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextfieldWidget(
                  textController: usernameController,
                  hintText: 'Username',
                ),
                const SizedBox(height: 24),
                TextfieldWidget(
                  textController: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                TextfieldWidget(
                  textController: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    if (registerInputHandler()) {
                      final String hashedPassword = BCrypt.hashpw(
                          passwordController.text, BCrypt.gensalt());
                      final int result =
                          await DatabaseHelper.instance.insertUser({
                        'username': usernameController.text,
                        'password': hashedPassword,
                      });
                      if (result > 0) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Register Success',
                              textAlign: TextAlign.center,
                            ),
                            behavior: SnackBarBehavior.floating,
                            width: 300,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Register Failed',
                              textAlign: TextAlign.center,
                            ),
                            behavior: SnackBarBehavior.floating,
                            width: 300,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Does have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
