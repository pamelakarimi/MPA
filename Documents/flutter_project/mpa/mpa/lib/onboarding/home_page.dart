import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Home"),backgroundColor: Colors.white,),
      body: const Center(child: Text("Welcome to the Home Page!")),
    );
  }
}
