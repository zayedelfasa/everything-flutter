import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/utils/link_route.dart';
import 'package:flutter/material.dart';
import 'chat_list_bloc.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

ChatListBloc listEventBloc;
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    listEventBloc = ChatListBloc();
  }

  @override
  void dispose() {
    super.dispose();
    listEventBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.primaryColor,
        title: Text("Room Event List", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("chat_room").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.documents
                    .map((doc) => listTile(doc))
                    .toList());
          } else {
            return SizedBox();
          }
        },
      )
    );
  }

  void showPostEvent() {
    Navigator.of(context).pushNamed(LinkRoute.ChatScreen);
  }

  ListTile listTile(DocumentSnapshot doc) {
    return ListTile(
      onTap: () {
        // this.displayDialog(doc);
        this.showPostEvent();
      },
      title: Text(doc.data['group_name']),
      dense: false,
    );
  }
}
// done
