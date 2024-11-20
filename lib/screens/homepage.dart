import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final String title;
  const HomeView({super.key,  required this.title});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uni Archive", style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}