import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone/Model/ChatModel.dart';
import 'package:flutter_whatsapp_clone/Pages/CameraPage.dart';
import 'package:flutter_whatsapp_clone/Pages/ChatPage.dart';
import 'package:flutter_whatsapp_clone/Pages/Statuspage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.chatmodels, this.sourchat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  TabController _controller;
  @override
  void initState() {
    super.initState();
     _controller=TabController(length: 4,vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp Clone"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
        body:TabBarView(
          controller: _controller,
          children: [
            CameraPage(),
            ChatPage(
              chatmodels: widget.chatmodels,
              sourchat: widget.sourchat,
            ),
            StatusPage(),
            Text("Calls"),
          ],
        ),
    );
  }
}
