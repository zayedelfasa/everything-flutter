import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/model/Comment.dart';
import 'package:flutter_bloc_example/model/Response.dart';
import 'package:flutter_bloc_example/pages/CommentPage/comment_bloc.dart';
import 'package:flutter_bloc_example/utils/app_constants.dart';
import 'package:flutter_bloc_example/widgets/post_widget.dart';

class CommentPage extends StatefulWidget {
  Map<String, dynamic> map;
  CommentPage(this.map);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  CommentBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CommentBloc();
    bloc.getComment(widget.map["id"].toString());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Comments"),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new PostWidget(widget.map),
              new Text("Comment"),
              new StreamBuilder(
                stream: bloc.commentStream(),
                initialData: Response(myState: MyState.loading, data: null),
                builder:
                    (BuildContext context, AsyncSnapshot<Response> snapshot) {
                  Response resp = snapshot.data;
                  print(resp.myState);
                  if (resp.myState == MyState.loading) {
                    return new CircularProgressIndicator();
                  } else if (resp.myState == MyState.data) {
                    List<Comment> cmts = resp.data;
                    return new Expanded(
                        child: new ListView.builder(
                      itemCount: cmts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return commentWidget(cmts[index]);
                      },
                    ));
                  } else if (resp.myState == MyState.error) {
                    // return new Text("Error get data");
                    return new Column(
                      children: <Widget>[
                        new Text(resp.data),
                        new RaisedButton(
                          child: new Text("Coba Ulangi"),
                          onPressed: () {
                            bloc.getComment(widget.map["id"].toString());
                          },
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget commentWidget(Comment comment) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new Text(comment.email, style: new TextStyle(color: Colors.blue)),
        new Text(comment.body),
      ],
    ));
  }
}
