import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/models/User.dart';
import 'package:provider_example/ui/shared/app_colors.dart';
import 'package:provider_example/ui/shared/text_style.dart';
import 'package:provider_example/ui/shared/ui_helpers.dart';
import 'package:provider_example/ui/views/Comments/comment_list.dart';

class PostView extends StatelessWidget {
  final Post post;
  const PostView({Key key, this.post}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Text(post.title, style: headerStyle),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium,
            Text(post.body),
            CommentList(post.id)
          ],
        ),
      ),
    );
  }
}