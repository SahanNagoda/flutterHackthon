import 'package:flutter/material.dart';
import 'package:hackthon/pages/home_page.dart';
import 'package:hackthon/pages/login_page.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:hackthon/views/home_tab.dart';
import 'package:hackthon/views/message_tab.dart';
import 'package:hackthon/views/notification_tab.dart';
import 'package:hackthon/views/profile_tab.dart';
import 'package:scoped_model/scoped_model.dart';

final AppModel model = AppModel();

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/login': (BuildContext context) => LoginPage(model),
          '/': (BuildContext context) => HomePage(model),
        },
      ),
    );
  }
}
