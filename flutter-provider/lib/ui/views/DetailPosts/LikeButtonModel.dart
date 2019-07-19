import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/services/PostsService.dart';

import '../../../locator.dart';

class LikeButtonModel extends BaseModel {
  PostsService _postsService = locator<PostsService>();

  int postLikes(int postId) {
    return _postsService.posts
        .firstWhere((post) => post.id == postId)
        .likes;
  }

  void increaseLikes(int postId) {
    _postsService.incrementLikes(postId);
    notifyListeners();
  }
}