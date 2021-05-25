import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone/CustomUi/CustomCard.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
       onPressed: (){

       },
       child: Icon(Icons.chat),
     ),
      body: ListView(
        children: [
          CustomCard(),
        ],
      ),
    );
  }
}
