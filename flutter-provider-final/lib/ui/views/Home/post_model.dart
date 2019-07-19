import 'package:flutter/widgets.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/services/api.dart';
import 'package:provider_example/ui/base/base_model.dart';

class PostsModel extends BaseModel {
  Api _api;

  PostsModel({
    @required Api api,
  }) : _api = api;

  List<Post> posts;

  Future getPosts(int userId) async {
    setBusy(true);
    posts = await _api.getPostsForUser(userId);
    setBusy(false);
  }
}
