import 'package:flutter/material.dart';
import 'package:gpt_chat/pages/imageChatPage.dart';
import 'package:gpt_chat/pages/textChatPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextChatScreen()));
                },
                child: Text('Chat with AI')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageChatPage()));
                },
                child: Text('Upload document')),
            ElevatedButton(
              onPressed: () {},
              child: Text('Talk with AI'),
            ),
            
          ],
        ),
      ),
    );
  }
}
