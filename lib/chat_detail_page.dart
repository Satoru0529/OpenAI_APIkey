import 'package:flutter/material.dart';
import 'message.dart';

class ChatDetailPage extends StatelessWidget {
  final Message message;

  ChatDetailPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(message.question),
            SizedBox(height: 16.0),
            Text('Answer:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(message.answer),
          ],
        ),
      ),
    );
  }
}
