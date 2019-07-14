import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutshare/model/daily_trends.dart';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/model/trends.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:flutshare/utils/endpoint.dart';

class ChatBloc {
  StreamController<Response> chatController = StreamController();
  Stream<Response> postStream() => chatController.stream;

  Future<void> getInterestovertime(String objek) async {
    print("PARAM : " + objek);
    Response resp = Response(statusState: StatusState.loading, data: null);
    chatController.sink.add(resp);

    await http
        .post(EndPoint.interestOverTime,
            headers: {"Content-Type": "application/json"},
            body: json.encode({"keyword": objek}))
        .then((res) {
      if (res.statusCode == 200) {
        print("DEFAULT : " + json.decode(res.body)['default'].toString());
        List<Trends> listTrends = [];
        Map<String, dynamic> map = json.decode(res.body)['default'];
        List<dynamic> list = map['timelineData'];
        listTrends = list.map((f) {
          // print("DATA F : " + f.toString());
          return new Trends.fromMap(f);
        }).toList();
        resp.statusState = StatusState.data;
        resp.data = listTrends;
        chatController.sink.add(resp);
      } else {
        print("error");
        resp.statusState = StatusState.error;
        resp.data = "Has Error";
        chatController.sink.add(resp);
      }
    }).catchError((onError) {
      print("error is : " + onError.toString());
      resp.statusState = StatusState.error;
      resp.data = "Has Error";
      chatController.sink.add(resp);
      print(onError.toString());
    });
  }

  Future<void> getInterestOverTimeCompare(List<String> listCompare) async {
    print("Data compare : " + json.encode(listCompare));
    Response resp = Response(statusState: StatusState.loading, data: null);
    chatController.sink.add(resp);

    await http
        .post(EndPoint.interestOverTimeMultiple,
            headers: {"Content-Type": "application/json"},
            body: json.encode({"keyword": listCompare}))
        .then((res) {
      if (res.statusCode == 200) {
        print("DEFAULT : " + json.decode(res.body)['default'].toString());
        List<Trends> listTrends = [];
        Map<String, dynamic> map = json.decode(res.body)['default'];
        List<dynamic> list = map['timelineData'];
        listTrends = list.map((f) {
          print("DATA F : " + f.toString());
          return new Trends.fromMap(f);
        }).toList();
        resp.statusState = StatusState.data;
        resp.data = listTrends;
        chatController.sink.add(resp);
      } else {
        print("error");
        resp.statusState = StatusState.error;
        resp.data = "Has Error";
        chatController.sink.add(resp);
      }
    }).catchError((onError) {
      print("error is : " + onError.toString());
      resp.statusState = StatusState.error;
      resp.data = "Has Error";
      chatController.sink.add(resp);
      print(onError.toString());
    });
  }

  Future<void> getDailyTrends() async {
    Response resp = Response(statusState: StatusState.loading, data: null);
    chatController.sink.add(resp);
    await http
        .post(EndPoint.dailyTrends,
            headers: {"Content-Type": "application/json"})
        .then((res) {
      if (res.statusCode == 200) {
        // print("DEFAULT : " + json.decode(res.body)['default']['trendingSearchesDays'].toString());
        List<DailyTrends> listTrends = [];
        Map<String, dynamic> map = json.decode(res.body)['default'];

        // print("MAP : " + map.toString());

        List<dynamic> list = map['trendingSearchesDays'][0]['trendingSearches'];
        listTrends = list.map((f) { 
          // print("DATA F : " + f.toString());
          return new DailyTrends.fromMap(f);
        }).toList();
        resp.statusState = StatusState.data;
        resp.data = listTrends;
        chatController.sink.add(resp);
      } else {
        print("error");
        resp.statusState = StatusState.error;
        resp.data = "Has Error";
        chatController.sink.add(resp);
      }
    }).catchError((onError) {
      print("error is : " + onError.toString());
      resp.statusState = StatusState.error;
      resp.data = "Has Error";
      chatController.sink.add(resp);
      print(onError.toString());
    });
  }

  void dispose() {
    chatController.close();
  }
}
