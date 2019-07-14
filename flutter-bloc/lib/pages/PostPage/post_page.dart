import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/model/Response.dart';
import 'package:flutter_bloc_example/pages/CommentPage/comment_page.dart';
import 'package:flutter_bloc_example/utils/app_constants.dart';
import 'package:flutter_bloc_example/pages/PostPage/post_bloc.dart';
import 'package:flutter_bloc_example/widgets/post_widget.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = new PostBloc();
    bloc.getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("POST PAGE"),
        ),
        body: StreamBuilder<Response>(
            stream: bloc.postStream(),
            initialData: Response(myState: MyState.loading, data: null),
            builder: (context, snapshot) {
              if (snapshot.data.myState == MyState.loading) {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              } else if (snapshot.data.myState == MyState.data) {
                return new ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                          child: new PostWidget(snapshot.data.data[index]),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new CommentPage(snapshot.data.data[index]);
                            }));
                          });
                    },
                    itemCount: snapshot.data.data.length);
              } else if (snapshot.data.myState == MyState.error) {
                // return new Center(child: new Text(snapshot.data.data));
                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(snapshot.data.data, textAlign: TextAlign.center),
                    new Center(
                      child: new RaisedButton(
                        child: new Text("Coba Ulangi"),
                        onPressed: () {
                          bloc.getData();
                        },
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
