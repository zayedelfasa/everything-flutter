import 'dart:async';
import 'package:flutshare/model/response.dart';

class SmsConfirmBloc {
  StreamController<Response> controller = StreamController();
  Stream<Response> postStream() => controller.stream;

  void dispose() {
    controller.close();
  }

  bool checkConfirmNumber(int number) {
    if(number == 1234) {
      return true;
    } else {
      return false;
    }
  }
}
