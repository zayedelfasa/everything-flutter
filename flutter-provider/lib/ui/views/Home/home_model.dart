import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/models/Post.dart';

import '../../../services/api.dart';

class HomeModel extends BaseModel {
  Api api = locator<Api>();
  List<Post> post;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    post = await api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}