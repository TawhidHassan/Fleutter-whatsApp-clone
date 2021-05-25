import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone/CustomUi/CustomCard.dart';
import 'package:flutter_whatsapp_clone/Model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatModel> chats=[
    ChatModel(
      name:"sifat",
      isGroup: false,
      currentMessage: "hi sifat",
      time: "4:40",
      icon: "assets/person.svg"
    ),
    ChatModel(
        name:"sifat",
        isGroup: false,
        currentMessage: "hi sifat",
        time: "4:40",
        icon: "assets/person.svg"
    ),
    ChatModel(
        name:"sifat",
        isGroup: true,
        currentMessage: "hi sifat",
        time: "4:40",
        icon: "assets/groups.svg"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
       onPressed: (){

       },
       child: Icon(Icons.chat),
     ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context,index)=>CustomCard(chatModel:chats[index]),
      ),
    );
  }
}
