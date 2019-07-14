import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutshare/model/news.dart';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:flutshare/utils/endpoint.dart';

class HomeBloc {
  StreamController<Response> newsController = StreamController();
  Stream<Response> postStream() => newsController.stream;
  StreamController<Response> idNewsController = StreamController();
  Stream<Response> idNewsStream() => idNewsController.stream;

  void getUsaNews() async {
    Response resp = Response(statusState: StatusState.loading, data: null);
    newsController.sink.add(resp);
    await http.get(EndPoint.newsApiHttpTopHeadLinesUsa).then((res) {
      if (res.statusCode == 200) {
        List<News> listNews = [];
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> list = map['articles'];
        print("Data : " + list.toList().toString());
        listNews = list.map((f){
          // print("DATA F : " + f.toString());
          return new News.fromMap(f);
        }).toList();
        resp.statusState = StatusState.data;
        resp.data = listNews;
        newsController.sink.add(resp);
      }
      else {
        print("error");
        resp.statusState = StatusState.error;
        resp.data = "Has Error";
        newsController.sink.add(resp);
      }
    }).catchError((onError) {
      print("error is : " + onError.toString());
      resp.statusState = StatusState.error;
      resp.data = "Has Error";
      newsController.sink.add(resp);
      print(onError.toString());
    });
  }

  void getIndonesianNews() async {
    Response resp = Response(statusState: StatusState.loading, data: null);
    idNewsController.sink.add(resp);

    await http.get(EndPoint.newsApiHttpTopHeadLinesID).then((res) {
      if (res.statusCode == 200) {
        List<News> listNews = [];
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> list = map['articles'];
        print("Data : " + list.toList().toString());
        listNews = list.map((f){
          // print("DATA F : " + f.toString());
          return new News.fromMap(f);
        }).toList();
        resp.statusState = StatusState.data;
        resp.data = listNews;
        idNewsController.sink.add(resp);
      }
      else {
        print("error");
        resp.statusState = StatusState.error;
        resp.data = "Has Error";
        idNewsController.sink.add(resp);
      }
    }).catchError((onError) {
      print("error is : " + onError.toString());
      resp.statusState = StatusState.error;
      resp.data = "Has Error";
      idNewsController.sink.add(resp);
      print(onError.toString());
    });
  }

  void dispose() {
    newsController.close();
    idNewsController.close();
  }
}
