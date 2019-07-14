import 'package:flutter/material.dart';

class SlideEffect extends MaterialPageRoute {
  SlideEffect({WidgetBuilder builder, RouteSettings settings}):
    super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);
    return SlideTransition(position: custom, child: child);
  }
}

class SlideEffectDuration extends PageRouteBuilder {
  Widget widget;
  SlideEffectDuration({this.widget}) : 
      super(
        pageBuilder : (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionDuration : Duration(milliseconds: 400),
        transitionsBuilder : (BuildContext context, Animation<double> animation, Animation secondaryAnimation, Widget child) {
          Animation<Offset> custom = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation);
          return SlideTransition(position: custom, child: child);
        }
      );
}

class FadeSlideDuration extends PageRouteBuilder {
  Widget widget;
  FadeSlideDuration({this.widget}) :
        super(
          pageBuilder : (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration : Duration(milliseconds: 1000),
          transitionsBuilder : (BuildContext context, Animation<double> animation, Animation secondaryAnimation, Widget child) {
            // Animation<double> custom = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            FadeTransition fadeCustom = new FadeTransition(opacity: animation, child: child);
            return fadeCustom;
          }
      );
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionDuration : Duration(milliseconds: 500),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
                children: <Widget>[
                  SlideTransition(
                    position: new Tween<Offset>(
                      begin: const Offset(0.0, 0.0),
                      end: const Offset(-1.0, 0.0),
                    ).animate(animation),
                    child: exitPage,
                  ),
                  SlideTransition(
                    position: new Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: enterPage,
                  )
                ],
              ),
        );
}