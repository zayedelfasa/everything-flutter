import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/model/Comment.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_example/model/Response.dart';
import 'package:flutter_bloc_example/utils/app_constants.dart';

class CommentBloc {
  StreamController<Response> controller = new StreamController();
  Stream<Response> commentStream() => controller.stream;

  getComment(String id) async {
    Response resp = new Response(myState: MyState.loading, data: null);
    controller.sink.add(resp);
    await http.get(COMMENT_LINK + id.toString()).then((res) {
      if (res.statusCode == 200) {
        List<Comment> listData = [];
        List<dynamic> list = json.decode(res.body);
        listData = list.map((listPost) {
          return new Comment.fromMap(listPost);
        }).toList();
        resp.myState = MyState.data;
        resp.data = listData;
        controller.sink.add(resp);
      } else {
        print("error");
        resp.myState = MyState.error;
        resp.data = "Has Error";
        controller.sink.add(resp);
      }
    }).catchError((onError) {
      resp.myState = MyState.error;
      resp.data = "Has Error";
      controller.sink.add(resp);
      print(onError.toString());
    });
  }

  void dispose() {
    controller.close();
  }
}
