import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  String newsUrl;
  String newsTitle;
  String newsCompany;
  NewsWebview({this.newsCompany, this.newsUrl, this.newsTitle});

  @override
  _NewsWebviewState createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.newsCompany),
        backgroundColor: DefaultColors.primaryColor,
      ),
      body: WebView(
        initialUrl: this.widget.newsUrl,
        javascriptMode: JavascriptMode.unrestricted
      )
    );
  }
}