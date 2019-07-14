import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutshare/utils/link_route.dart';
import 'package:flutter/material.dart';
import 'package:flutshare/styles/default_colors.dart';

import 'event_list_bloc.dart';

class EventListEvent extends StatefulWidget {
  @override
  _ListEventState createState() => _ListEventState();
}

class _ListEventState extends State<EventListEvent> {
  ListEventBloc listEventBloc;
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    listEventBloc = ListEventBloc();
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
        title: Text("Event List", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("event").snapshots(),
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
      ),
      // body: Material(
      //   child: null,
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: this.showPostEvent,
        child: Icon(Icons.add),
        backgroundColor: DefaultColors.primaryColor,
      ),
    );
  }

  void showPostEvent() {
    Navigator.of(context).pushNamed(LinkRoute.PostEventPage);
  }

  ListTile listTile(DocumentSnapshot doc) {
    return ListTile(
      onTap: () {
        this.displayDialog(doc);
      },
      title: Text(doc.data['name']),
      subtitle: Text(doc.data['adress']),
      dense: false,
    );
  }

  displayDialog(DocumentSnapshot doc) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Event Description'),
            content: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(doc.data['description']),
                Text("Do you want to join this event and group?")
              ]),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();                  
                },
              ),
              new FlatButton(
                child: new Text('Cancel',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
