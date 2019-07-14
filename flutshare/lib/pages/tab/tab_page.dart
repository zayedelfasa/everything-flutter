import 'package:flutshare/pages/chat_list/chat_list_page.dart';
import 'package:flutshare/pages/chat_page/ChatScreen.dart';
import 'package:flutshare/pages/event_list/event_list_page.dart';
import 'package:flutshare/pages/home/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:neta/pages/chat_bot/ChatScreen.dart';
// import 'package:neta/pages/home/home_page.dart';
// import 'package:neta/pages/list_event/list_event_page.dart';
// import 'package:neta/pages/news_list/news_page.dart';
// import 'package:neta/pages/post_event/post_event_page.dart';
import 'package:flutshare/styles/default_colors.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  int tabNow = 0;
  final List<Widget> _children = [
    new HomePage(),
    // new NewsList(),
    // new CharScreen(),
    // new PostEvent(),
    // new ListEvent(),
    // Container(color: DefaultColors.primaryColor),
    new EventListEvent(),
    // Container(color: DefaultColors.primaryColor),
    // new CharScreen(),
    new ChatList(),
    Container(color: DefaultColors.primaryColor)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, //this.showAppbar(this.tabTitle),
      body: _children[tabNow],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabNow,
        fixedColor: DefaultColors.primaryColor,
        onTap: this.onNavigationTap,
        items: _buildNavigationItems(),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void onNavigationTap(val) {
    switch (val) {
      case 0:
        setState(() {
          tabNow = val;
        });
        break;
      case 1:
        setState(() {
          tabNow = val;
        });
        break;
      case 2:
        setState(() {
          tabNow = val;
        });
        break;
      case 3:
        setState(() {
          tabNow = val;
        });
        break;
    }
    print("tab val : " + val.toString());
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          title: Text('Trends'),
          icon: Icon(
            Icons.home,
            size: 26,
          )),
      BottomNavigationBarItem(
          title: Text('Event'),
          icon: Icon(
            Icons.rss_feed,
            size: 26,
          )),
      BottomNavigationBarItem(
          title: Text('Chat'),
          icon: Icon(
            Icons.message,
            size: 26,
          )),
      BottomNavigationBarItem(
          title: Text('Account'),
          icon: Icon(
            Icons.perm_identity,
            size: 26,
          ))
    ];
  }
}
