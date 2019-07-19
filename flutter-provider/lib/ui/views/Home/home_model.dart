import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/services/PostsService.dart';

import '../../../services/api.dart';

class HomeModel extends BaseModel {
  PostsService _postsService = locator<PostsService>();
  
  List<Post> get posts => _postsService.posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    await _postsService.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}