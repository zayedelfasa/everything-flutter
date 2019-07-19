import 'package:flutter/material.dart';
import 'package:provider_example/constants/app_constants.dart';
import 'package:provider_example/models/Post.dart';
import 'package:provider_example/ui/views/login/login_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.Post:
      // var post = settings.arguments as Post;
      // return MaterialPageRoute(builder: (_) => PostView(post: post));
      case RoutePaths.Home:
      // return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
