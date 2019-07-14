import 'dart:async';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterBloc {
  StreamController<Response> regisController = StreamController();
  Stream<Response> postStream() => regisController.stream;
  final db = Firestore.instance;

 Future<void> newUserRegister1(String phoneNumber) async {
   Response resp = new Response(statusState: StatusState.loading, data: null);
   regisController.sink.add(resp);
   DocumentReference ref = await db.collection('users').add({'phone_number' : '$phoneNumber'});
   resp.statusState = StatusState.data;
   resp.data = ref;
   regisController.sink.add(resp);
 }

  Future<String> newUserRegister(String phoneNumber) async {
    // DocumentReference ref = await db.collection('users').add({'phone_number' : '$phoneNumber'});
    // return ref.documentID;
    return phoneNumber;
  }

  void dispose() {
    regisController.close();
  }
}
