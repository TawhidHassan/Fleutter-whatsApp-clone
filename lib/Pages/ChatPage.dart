import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone/CustomUi/CustomCard.dart';
import 'package:flutter_whatsapp_clone/Model/ChatModel.dart';
import 'package:flutter_whatsapp_clone/Screens/SelectContactScreen.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.chatmodels, this.sourchat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
       onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectContact()));
       },
       child: Icon(Icons.chat),
     ),
      body: ListView.builder(
        itemCount:widget.chatmodels.length,
        itemBuilder: (context,index)=>CustomCard(
          chatModel: widget.chatmodels[index],
          sourchat: widget.sourchat,
        ),
      ),
    );
  }
}
