import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test/screens/quiz.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: ElevatedButton(
                onPressed: () {
                  Get.to(const Quiztest());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                ),
                child: Text('Start Quiz'),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
