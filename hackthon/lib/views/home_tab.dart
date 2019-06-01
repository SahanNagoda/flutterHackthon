import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';

class HomeTab extends StatefulWidget {
  final AppModel model;

  @override
  _HomeTabState createState() => _HomeTabState();

  HomeTab(this.model, {Key key}) : super(key: key);
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'home',
      ),
    );
  }
}
