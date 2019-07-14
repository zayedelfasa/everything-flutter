import 'dart:async';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/pages/post_event/post_event_page.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListEventBloc {
  StreamController<Response> listEventController = StreamController();
  Stream<Response> postStream() => listEventController.stream;
  final db = Firestore.instance;

  Future<void> getEvent() async {
    Response resp = new Response(statusState: StatusState.loading, data: null);
    listEventController.sink.add(resp);
    DocumentSnapshot snapshot = await db.collection('users').document().get();
    resp.statusState = StatusState.data;
    resp.data = snapshot;
    listEventController.sink.add(resp);
  }

  void insertUserDataEvent(DocumentSnapshot doc, String groupName, int isAttended, String roomID) async {
    // await db.collection("event_user_attended").document(doc.documentID).updateData({'phone_number' : '+6281234567890'});
    print("ON FUTURE newPostEvent right now");
    Response resp = new Response(statusState: StatusState.loading, data: null);
    listEventController.sink.add(resp);
    DocumentReference reff =
        await db.collection('event_user_attended').add({
          'room_id': roomID,
          'is_attended': isAttended,
          'event_id' : doc.documentID,
          'event_name' : groupName
        });
    resp.statusState = StatusState.data;
    resp.data = reff;
    listEventController.sink.add(resp);
  }

  void dispose() {
    listEventController.close();
  }
}