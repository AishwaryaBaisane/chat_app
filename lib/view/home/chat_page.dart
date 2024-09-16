import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat_page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              ),
            ),
          )
        ],
      ),
    );
  }
}
