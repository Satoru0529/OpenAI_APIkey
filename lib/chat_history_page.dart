import 'package:flutter/material.dart';
import 'chat_detail_page.dart';
import 'chat_screen.dart';
import 'message.dart';
import 'firebase_service.dart';

class ChatHistoryPage extends StatefulWidget {
  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final messages = await FirebaseService.loadMessages();
    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
      ),
      body:ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return ListTile(
            title: Text('${message.question}'),
            //subtitle: Text('Answer: ${message.answer}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(message: message),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
