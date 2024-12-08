import 'package:flutter/material.dart';
import 'package:todo_app/pages/form.dart';
import 'package:todo_app/pages/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/form': (context) => const FormScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
