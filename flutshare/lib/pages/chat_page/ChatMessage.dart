import 'package:flutter/material.dart';
import 'package:flutshare/model/trends.dart';

class ChatMessage extends StatelessWidget {
  String textMessage;
  int tipe;
  String userName;
  Trends tren;
  String userWhoChat;

  ChatMessage({this.textMessage, this.tipe, this.userName, this.tren, this.userWhoChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6.0, top: 6.0, bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: CircleAvatar(
              child: Image.network(
                  "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.userName, style: Theme.of(context).textTheme.subhead),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: boxMessage(this.tipe),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget boxMessage(int tipe) {
    if(this.userWhoChat.contains("user")) {
      return Text(this.textMessage);
    } else {
      switch (tipe) {
      case 0:
        return Text("interestovertime");
      case 0:
        return Text("compareinterestovertime");
      case 0:
        return Text("dailytrends");
      case 0:
        return Text("interestbyregion");
      case 0:
        return Text("realtimetrends");
        break;
      default:
        return Text("Wrong Command");
    }
    }
  }
}
