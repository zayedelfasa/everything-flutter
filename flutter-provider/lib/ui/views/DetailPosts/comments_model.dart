import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/models/Comment.dart';

import '../../../services/api.dart';

class CommentsModel extends BaseModel {
  Api api = locator<Api>();

  List<Comment> comments;

  Future getComment(int postId) async {
    setState(ViewState.Busy);
    comments = await api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
}