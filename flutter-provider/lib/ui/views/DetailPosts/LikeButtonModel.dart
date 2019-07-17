import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/services/PostsService.dart';

class LikeButtonModel extends BaseModel {
  PostsService postsService = locator<PostsService>();

  int postLike(int postId) {
    return postsService.posts.firstWhere((post) => post.id == postId).likes;
  }

  void increaseLikes(int postId) {
    postsService.incrementLikes(postId);
    notifyListeners();
  }
}