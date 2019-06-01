import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:hackthon/views/home_tab.dart';
import 'package:hackthon/views/message_tab.dart';
import 'package:hackthon/views/notification_tab.dart';
import 'package:hackthon/views/profile_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  final AppModel model;
  HomePage(this.model);
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages;
  int _index = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    pages = [
      HomeTab(
        widget.model,
        key: PageStorageKey('HomeTab'),
      ),
      MessageTab(
        widget.model,
        key: PageStorageKey('MessageTab'),
      ),
      NotificationTab(
        widget.model,
        key: PageStorageKey('NotificationTab'),
      ),
      ProfileTab(
        widget.model,
        key: PageStorageKey('ProfileTab'),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: PageStorage(bucket: bucket, child: pages[_index]),
        bottomNavigationBar: BottomNavigationBar(
          items: _getBottomNavBar(),
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              if (_index == 0 && index == 0) {
                widget.model.setHomeTabState(1);
              }
              _index = index;
            });
          },
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavBar() {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.blue,
        ),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.snooze,
          color: Colors.blue,
        ),
        title: Text(
          'Message',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.notifications,
          color: Colors.blue,
        ),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ];
    return items;
  }
}
