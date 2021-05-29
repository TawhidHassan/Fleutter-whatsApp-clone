// import 'package:camera/camera.dart';
// import 'package:chatapp/CustomUI/CameraUI.dart';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_whatsapp_clone/CustomUi/OwnMessageCard.dart';
import 'package:flutter_whatsapp_clone/Model/ChatModel.dart';
import 'package:flutter_whatsapp_clone/Model/MessageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class IndividualPage extends StatefulWidget {
  IndividualPage({Key key, this.chatModel, this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  bool sendButton = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];

  IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://172.28.0.1:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
    socket.emit("/test","hello world");
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Stack(
                children: [
                  // Expanded(
                  //     child: ListView.builder(
                  //       shrinkWrap: true,
                  //       controller: _scrollController,
                  //       itemCount:10,
                  //       itemBuilder: (context,index){
                  //         return OwnMessageCard(message: "sfccccccccccccccccccccccccccccccccccccjsjss",time: "22:2",);
                  //       },
                  //     )
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (_controller.text!="") {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        show
                                            ? Icons.keyboard
                                            : Icons.emoji_emotions_outlined,
                                      ),
                                      onPressed: () {
                                        if (!show) {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                        }
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            if (!show) {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                            }
                                            showModalBottomSheet(
                                                backgroundColor:
                                                Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet());

                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {

                                          },
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8,
                                right: 2,
                                left: 2,
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xFF128C7E),
                                child: IconButton(
                                  icon: Icon(
                                    sendButton ? Icons.send : Icons.mic,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {


                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        show ? emojiSelect() : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              onWillPop:(){
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),

          ),
        ),
      ],
    );
  }


  Widget bottomSheet() {
    return Container(
        height: 278,
        width: MediaQuery.of(context).size.width,
        child: Card(
            margin: const EdgeInsets.all(18.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconCreation(
                              Icons.insert_drive_file, Colors.indigo, "Document"),
                          SizedBox(
                            width: 40,
                          ),
                          iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                          SizedBox(
                            width: 40,
                          ),
                          iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconCreation(Icons.headset, Colors.orange, "Audio"),
                          SizedBox(
                            width: 40,
                          ),
                          iconCreation(Icons.location_pin, Colors.teal, "Location"),
                          SizedBox(
                            width: 40,
                          ),
                          iconCreation(Icons.person, Colors.blue, "Contact"),
                        ],
                      ),
                    ]
                )
            )
        )
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }


  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          // print(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
            print( _controller.text);
          });
        });
  }


}