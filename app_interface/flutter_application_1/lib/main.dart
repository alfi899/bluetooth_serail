import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff232d37),
        appBarTheme: const AppBarTheme(color: Color(0xff232d37)),
      ),
      home: const HomePage(),
    );
  }
}