import 'package:flutter/material.dart';
import 'package:mpa/onboarding/sign_in_page.dart';
import 'package:mpa/themes/app_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkColor,
      ),
      home: SignInPage()
    );
  }
}

