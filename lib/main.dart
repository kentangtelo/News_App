import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_proyek/model/news_hive_model.dart';
import 'package:news_app_proyek/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/bottom_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final bool loggedIn = sharedPreferences.getBool('rememberLogin') ?? false;
  await Hive.initFlutter();

  Hive.registerAdapter(NewsHiveModelAdapter());
  await Hive.openBox('newsHiveBox');

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: loggedIn ? const BottomNav() : const LoginScreen(),
    );
  }
}
