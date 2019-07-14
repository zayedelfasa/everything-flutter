import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class News {
  Source tempSource;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  News({this.tempSource,this.author,this.title,this.description,this.url,this.urlToImage,this.publishedAt,this.content});

  News.fromMap(Map<String, dynamic> map) {
    // print("DATA NEWS MAP ID: " + map['source'].toString());
    this.tempSource = new Source.fromJson(map['source']);
    this.author = map['author'];
    this.title = map['title'];
    this.description = map['description'];
    this.url = map['url'];
    this.urlToImage = map['urlToImage'];
    this.publishedAt = map['publishedAt'];
    this.content = map['content'];
  }
}

@JsonSerializable(nullable: true)
class Source {
  String name;
  String id;
  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> _map) {
    // print("DATA NEWS MAP SOURCE: " + _map.toString());
    this.id = _map['id'] == null ? "" : _map['id'].toString();
    this.name = _map['name'];
  }
}
