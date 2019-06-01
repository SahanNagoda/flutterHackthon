import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';

class MessageTab extends StatefulWidget {
  final AppModel model;

  @override
  _MessageTabState createState() => _MessageTabState();

  MessageTab(this.model, {Key key}) : super(key: key);
}

class _MessageTabState extends State<MessageTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'message',
      ),
    );
  }
}
