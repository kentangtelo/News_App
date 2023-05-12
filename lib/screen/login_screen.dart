import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/register_screen.dart';
import 'package:news_app_proyek/widget/bottom_navigator.dart';
import 'package:news_app_proyek/widget/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/db_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  loginInputHandler() {
    bool isFilled = true;
    if (usernameController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Username can\'t empty',
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
            'Warning! Password can\'t empty',
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
                    'Sign In',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    if (loginInputHandler()) {
                      final List<Map<String, dynamic>> result =
                          await DatabaseHelper.instance
                              .selectUser(usernameController.text);
                      if (result.isNotEmpty) {
                        final String hashedPassword = result[0]['password'];
                        final bool isPasswordMatch = BCrypt.checkpw(
                            passwordController.text, hashedPassword);
                        if (isPasswordMatch) {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setBool(
                              'rememberLogin', isPasswordMatch);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Success',
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
                              builder: (context) => const BottomNav(),
                            ),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Failed',
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                              width: 300,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Login Failed',
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
                      'Login',
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
                      'Doesn\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
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
