import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Trends {
  String time;
  String formattedTime;
  String formattedAxisTime;
  List<int> value;
  List<String> formattedValue;

  Trends({this.time, this.formattedTime, this.formattedAxisTime, this.value, this.formattedValue});

  Trends.fromMap(Map<String, dynamic> map) {
    this.time = map['time'];
    this.formattedTime = map['formattedTime'];
    this.formattedAxisTime = map['formattedAxisTime'];
    this.value = map['value'].cast<int>();
    this.formattedValue = map['formattedValue'].cast<String>();
  }
}