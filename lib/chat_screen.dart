import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'message.dart';
import 'answer_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String _response = '';

  Future<String> sendQuestion(String question) async {
    //final apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';
    final apiUrl = 'https://api.openai.com/v1/engines/davinci/completions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer sk',
    };
    final body = {
      'prompt': '$question\nA:',
      'max_tokens': 50,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to send question.');
    }
  }

  void _sendMessage() async {
    String question = _textEditingController.text.trim();
    if (question.isNotEmpty) {
      // ChatGPTのAPI呼び出し
      String answer = await sendQuestion(question);
      // Firestoreにメッセージを保存
      Message message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        question: question,
        answer: answer,
      );
      await FirebaseService.saveMessage(message);

      // AnswerScreenに遷移
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerScreen(answer: message.answer),
        ),
      );

      // テキストフィールドをクリア
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Ask a question',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
