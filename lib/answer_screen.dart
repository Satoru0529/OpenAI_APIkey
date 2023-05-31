import 'package:flutter/material.dart';

class AnswerScreen extends StatelessWidget {
  final String answer;

  AnswerScreen({required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer'),
      ),
      body: Center(
        child: Text(answer),
      ),
    );
  }
}
