import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';

class ProfileTab extends StatefulWidget {
  final AppModel model;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  ProfileTab(this.model, {Key key}) : super(key: key);
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'home',
      ),
    );
  }
}
