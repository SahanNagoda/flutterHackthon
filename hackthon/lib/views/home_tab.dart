import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:hackthon/views/home_tab_pages/add_post.dart';
import 'package:hackthon/views/home_tab_pages/posts.dart';

class HomeTab extends StatefulWidget {
  static int homeTabState = POST_LIST;
  final AppModel model;

  @override
  _HomeTabState createState() => _HomeTabState();

  HomeTab(this.model, {Key key}) : super(key: key);
}

const POST_LIST = 1;
const POST_ADD = 2;

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PostsPage(),
          HomeTab.homeTabState == POST_ADD ? AddPostPage() : Container(),
        ],
      ),
      floatingActionButton: _getFab(),
    );
  }

  _getFab() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          widget.model.setHomeTabState(POST_ADD);
        });
      },
    );
  }
}
