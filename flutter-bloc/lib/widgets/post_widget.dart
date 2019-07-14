import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  Map<String, dynamic> map;
  PostWidget(this.map);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Text("User id : " + map["userId"].toString()),
          new Text("User id : " + map["id"].toString()),
          new Text("User id : " + map["title"].toString(),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          new Text("User id : " + map["body"].toString()),
        ],
      ));
  }
}