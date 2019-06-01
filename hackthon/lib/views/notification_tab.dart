import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';

class NotificationTab extends StatefulWidget {
  final AppModel model;

  @override
  _NotificationTabState createState() => _NotificationTabState();

  NotificationTab(this.model, {Key key}) : super(key: key);
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'notification',
      ),
    );
  }
}
