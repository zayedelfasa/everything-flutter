import 'package:flutshare/pages/chat_page/ChatScreen.dart';
import 'package:flutshare/pages/first_page/first_page.dart';
import 'package:flutshare/pages/login/login_page.dart';
import 'package:flutshare/pages/post_event/post_event_page.dart';
import 'package:flutshare/pages/splash/splash_page.dart';
import 'package:flutshare/pages/tab/tab_page.dart';
import 'package:flutshare/utils/link_route.dart';
import 'package:flutshare/utils/slide_effect.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    return MaterialApp(
      home: new SplashPage(),
      onGenerateRoute: (RouteSettings settings) {
      if (settings.name == LinkRoute.FirstPage) {
        //return MaterialPageRoute(builder: (context) => new FirstPage());
        return new FadeSlideDuration(widget: new FirstPage());
      } 
      
      else if (settings.name == LinkRoute.LoginPage) {
        return new SlideEffectDuration(widget: new LoginPage());
      }
       
      // else if (settings.name == LinkRoute.RegisterPage) {
      //   return new SlideEffectDuration(widget: new RegisterPage());
      // }
      // else if (settings.name == LinkRoute.SmsConfirmPage) {
      //   return new SlideEffectDuration(widget: new SmsPage(null));
      // } 

      else if (settings.name == LinkRoute.TabPage) {
        return new FadeSlideDuration(widget: new TabPage());
      } 

      // else if (settings.name == LinkRoute.NewsWebview) {
      //   return new SlideEffectDuration(
      //       widget: new NewsWebview(
      //           newsCompany: null, newsTitle: null, newsUrl: null));
      // }

      else if (settings.name == LinkRoute.PostEventPage) {
        return new SlideEffectDuration(widget: new PostEvent());
      }

      else if(settings.name == LinkRoute.ChatScreen) {
        return new SlideEffectDuration(widget: new CharScreen());
      }   
    },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
