import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/Comment.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/ui/shared/app_colors.dart' as prefix0;
import 'package:provider_example/ui/views/DetailPosts/comments_model.dart';
import 'package:provider_example/ui/views/base_view.dart';

import '../../../enums/viewstate.dart';
import '../../../models/User.dart';
import '../../shared/app_colors.dart';
import '../../shared/text_style.dart';
import '../../shared/ui_helpers.dart';

class PostView extends StatelessWidget {
  final Post post;

  PostView({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prefix0.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(post.title, style: headerStyle),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            Comments(postId: post.id)
          ],
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  final int postId;
  Comments({this.postId});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentsModel>(
      onModelReady: (model) => model.getComment(postId),
      builder: (context, model, child) => model.state == ViewState.Busy 
      ? Center(child: CircularProgressIndicator())
      : Expanded(child: ListView(children: model.comments
                  .map((comment) => CommentItem(comment: comment,)).toList()))
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  CommentItem({this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall(),
          Text(comment.body),
        ],
      ),
    );
  }
}

