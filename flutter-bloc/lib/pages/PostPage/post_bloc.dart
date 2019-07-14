import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc_example/model/Response.dart';
import 'package:flutter_bloc_example/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class PostBloc {
  StreamController<Response> postController = StreamController();
  Stream<Response> postStream() => postController.stream;

  getData() async {
    Response resp = Response(myState: MyState.loading, data: null);
    postController.sink.add(resp);
    List<Map<String, dynamic>> listData = [];
    await http.get(POST_LINK).then((res) {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);

        listData = list.map((listPost) {
          Map<String, dynamic> map = new Map();
          map["userId"] = listPost["userId"];
          map["id"] = listPost["id"];
          map["title"] = listPost["title"];
          map["body"] = listPost["body"];
          return map;
        }).toList();

        resp.myState = MyState.data;
        resp.data = listData;

        postController.sink.add(resp);
      } else {
        print("error");
        resp.myState = MyState.error;
        resp.data = "Data Fetch Error";
        postController.sink.add(resp);

      }
    }).catchError((e) {
      resp.myState = MyState.error;
      resp.data = "Data Fetch Error";
      postController.sink.add(resp);
    });
  }

  void dispose() {
    postController.close();
  }
}