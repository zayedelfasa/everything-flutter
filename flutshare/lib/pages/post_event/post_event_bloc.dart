import 'dart:async';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/pages/post_event/post_event_page.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostEventBloc {
  StreamController<Response> postEventController = StreamController();
  Stream<Response> postStream() => postEventController.stream;
  final db = Firestore.instance;

  Future<void> newPostEvent(PostEventValue postEventValue) async {
    print("ON FUTURE newPostEvent right now");
    Response resp = new Response(statusState: StatusState.loading, data: null);
    postEventController.sink.add(resp);
    DocumentReference reff = await db.collection('event').add({
      'adress': postEventValue.address.toString(),
      'name': postEventValue.name.toString(),
      'pic': postEventValue.pic.toString(),
      'coordinate': postEventValue.coordinate,
      'description': postEventValue.deskripsi.toString()
    });

    // DocumentReference reffCreateGroup = await
    resp.statusState = StatusState.data;
    resp.data = reff;
    postEventController.sink.add(resp);
  }

  void createGroup() async {
    // DocumentReference reff =
    //     await db.collection('event').add({
    //       'adress': postEventValue.address.toString(),
    //       'name': postEventValue.name.toString(),
    //       'pic' : postEventValue.pic.toString(),
    //       'coordinate' : postEventValue.coordinate,
    //       'description' : postEventValue.deskripsi.toString()
    //     });

    // await db.

    Firestore.instance.runTransaction((transaction) async {
      final CollectionReference postsRef = db.collection('/chat_room');
      var postID = 1;
      Post post = new Post( postID, "title", "content");
      
      postsRef.document(postID.toString()).setData({"is": "isss"});

      // print(test);
      // await db.collection("chat_room").add({'documentID' : 'test123'});
    });
  }

  void dispose() {
    postEventController.close();
  }
}

class Post {
  int postID;
  String title;
  String content;

  Post(this.postID, this.title, this.content);
}
