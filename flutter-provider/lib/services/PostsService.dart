import 'package:provider_example/models/Post.dart';

import '../locator.dart';
import 'api.dart';

class PostsService {
  Api api = locator<Api>();
  
  List<Post> _posts;
  List<Post> get posts => _posts;

  Future getPostsForUser(int userId) async {
    _posts = await api.getPostsForUser(userId);
  }

  void incrementLikes(int postId){
    _posts.firstWhere((post) => post.id == postId).likes++;
  }
}