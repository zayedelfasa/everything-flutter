import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/ui/shared/ui_helpers.dart';
import 'package:provider_example/ui/views/Home/home_model.dart';
import 'package:provider_example/ui/views/base_view.dart';

import '../../../models/User.dart';
import '../../shared/app_colors.dart';
import '../../shared/text_style.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, widget) => Scaffold(
            backgroundColor: backgroundColor,
            body: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UIHelper.verticalSpaceLarge(),
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
                      UIHelper.verticalSpaceSmall(),
                      Expanded(child: getPostsUi(model.post),)
                    ],
                  ),
          ),
    );
  }

  Widget getPostsUi(List<Post> posts) => ListView.builder(
    itemCount: posts.length,
     itemBuilder: (context, index) => PostListItem(
      post: posts[index],
      onTap: () {
        // print("Klik me to go navigate post");
        Navigator.pushNamed(context, 'post', arguments: posts[index]);
      },
     )
  );
}

class PostListItem extends StatelessWidget {
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
