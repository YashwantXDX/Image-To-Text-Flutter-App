import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ShowUI(),
    );
  }
}

class ShowUI extends StatefulWidget {
  const ShowUI({super.key});

  @override
  State<ShowUI> createState() => _ShowUIState();
}

class _ShowUIState extends State<ShowUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My First App in Vs Code")),
        backgroundColor: Colors.red.shade500,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("My Name is Yashwant."),
            Text("I am currently pursuing MCA from MATS University."),
            Text("MATS University just got their NAAC Grading of A+.")
          ],
        ),
      ),
    );
  }
}
