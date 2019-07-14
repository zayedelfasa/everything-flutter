import 'package:flutter/material.dart';
import 'package:flutshare/pages/chat_page/ChatBloc.dart';
import 'package:flutshare/pages/chat_page/ChatCustomDialog.dart';
import 'package:flutshare/pages/chat_page/ChatMessage.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';

class CharScreen extends StatefulWidget {
  @override
  _CharScreenState createState() => _CharScreenState();
}

class _CharScreenState extends State<CharScreen> {
  final TextEditingController chatController = TextEditingController();
  final List<ChatMessage> messages = <ChatMessage>[];
  ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    chatBloc = new ChatBloc();
  }

  @override
  void dispose() {
    super.dispose();
    chatBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DefaultColors.primaryColor,
          title: Text("Event Group",
              style: TextStyle(color: Colors.white))),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return messages[index];
              },
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: chatEnvironment(),
          )
        ],
      ),
    );
  }

  Widget chatEnvironment() {
    return IconTheme(
      data: IconThemeData(color: DefaultColors.primaryColor),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: "Typing here..."),
                  controller: chatController,
                  onSubmitted: handleSubmit,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => handleSubmit(chatController.text),
                ),
              )
            ],
          )),
    );
  }

  Future<void> handleSubmit(String text) async {
    chatController.clear();

    ChatMessage message = new ChatMessage(
      textMessage: text,
      tipe: typeMessage(text),
      userName: "Zayed Elfasa",
      userWhoChat: "user",
    );

    setState(() {
      messages.insert(0, message);
    });
    this.handleBot(text);
  }

  Future<void> handleBot(String text) async {
    ChatMessage message;
    int tipeInterest = typeMessage(text);

    // interest overtime
    if (tipeInterest == 0) {
      // await showDialog(
      //   context: context,
      //   builder: (BuildContext context) => ChatDialogInterestOverTime(
      //         title: "Keyword",
      //         description: "",
      //         buttonText: "Choose",
      //         chatBloc: chatBloc,
      //       ),
      // );
      _displayDialog(context);
    } else if (typeMessage(text) == 1) {
      _displayDialogCompare(context);
    }
    else if(typeMessage(text) == 2) {
      chatBloc.getDailyTrends();
    } else if(typeMessage(text) == 3) {

    } else if(typeMessage(text) == 4) {

    } else {
      message = new ChatMessage(
        textMessage: text,
        tipe: typeMessage(text),
        userName: "NetaBot",
        userWhoChat: "bot",
      );
    }

    // message = new ChatMessage(
    //   textMessage: text,
    //   tipe: typeMessage(text),
    //   userName: "NetaBot",
    //   userWhoChat: "bot",
    // );

    // setState(() {
    //   messages.insert(0, message);
    // });
  }

  int typeMessage(String message) {
    int type;
    print("MESSAGE : " +
        message.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
    switch (message.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), "")) {
      case 'interestovertime':
      case 'a':
        type = 0;
        break;
      case 'compareinterestovertime':
      case 'b':
        type = 1;
        break;
      case 'dailytrends':
      case 'c':
        type = 2;
        break;
      case 'interestbyregion':
        type = 3;
        break;
      case 'realtimetrends':
        type = 4;
        break;
      default:
        type = 5;
    }
    return type;
  }

  _displayDialog(BuildContext context) async {
    String keyword;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Interest Overtime'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textFieldController,
                decoration: DefaultStyle()
                    .defaultInputDecorationForm("Input Keyword Here"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Input Keyword Overtime";
                  }
                },
                onSaved: (value) => keyword = value,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    chatBloc.getInterestovertime(_textFieldController.text);
                    Navigator.of(context).pop();
                  }
                },
              ),
              new FlatButton(
                child: new Text('Cancel',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _displayDialogCompare(BuildContext context) async {
    String keyword1;
    String keyword2;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _textFieldControllerCompare1 =
        TextEditingController();
    final TextEditingController _textFieldControllerCompare2 =
        TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Compare Interest Overtime'),
            content: Form(
              key: _formKey,
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _textFieldControllerCompare1,
                      decoration: DefaultStyle()
                          .defaultInputDecorationForm("Input First Keyword Here"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Input Keyword Overtime";
                        }
                      },
                      onSaved: (value) => keyword1 = value,
                    ),
                    TextFormField(
                      controller: _textFieldControllerCompare2,
                      decoration: DefaultStyle()
                          .defaultInputDecorationForm("Input Second Keyword Here"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Input Keyword Overtime";
                        }
                      },
                      onSaved: (value) => keyword2 = value,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    List<String> list = [_textFieldControllerCompare1.text , _textFieldControllerCompare2.text];
                    chatBloc.getInterestOverTimeCompare(list);
                    Navigator.of(context).pop();
                  }
                },
              ),
              new FlatButton(
                child: new Text('Cancel',
                    style: TextStyle(color: DefaultColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
