import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/constants/app_constants.dart';
import 'package:provider_example/models/User.dart';
import 'package:provider_example/ui/base/base_widget.dart';
import 'package:provider_example/ui/shared/app_colors.dart';
import 'package:provider_example/ui/shared/text_style.dart';
import 'package:provider_example/ui/shared/ui_helpers.dart';
import 'package:provider_example/ui/views/Home/post_model.dart';
import 'package:provider_example/models/Post.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceLarge,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Welcome ${Provider.of<User>(context).name}',
              style: headerStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Here are all your posts', style: subHeaderStyle),
          ),
          UIHelper.verticalSpaceSmall,
          Expanded(child: PostsList(),)
        ],
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsModel>(
      model: PostsModel(api: Provider.of(context)),
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => model.busy ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostListItem(
                      post: model.posts[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutePaths.Post,
                          arguments: model.posts[index],
                        );
                      },
                    ),
              )
    );
  }
}

class  PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  const PostListItem({this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(post.title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),),
            Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}



