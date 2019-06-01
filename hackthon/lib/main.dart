import 'package:flutter/material.dart';
import 'package:hackthon/pages/home_page.dart';
import 'package:hackthon/pages/login_page.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:hackthon/views/home_tab.dart';
import 'package:hackthon/views/message_tab.dart';
import 'package:hackthon/views/notification_tab.dart';
import 'package:hackthon/views/profile_tab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _handleCurrentScreen(),
        routes: {
          '/login': (BuildContext context) => LoginPage(model),
          '/home': (BuildContext context) => HomePage(model),
        },
      ),
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("SplashScreen");
            String route = "/login";
            return LoginPage(model);
          } else {
            if (snapshot.hasData) {
              print(snapshot.data);
              String route = "/login";
              return HomePage(model);
            } else if (snapshot.hasError) {
              print(snapshot.error);
              String route = "/login";
              return LoginPage(model);
            }
            String route = "/login";
            return LoginPage(model);
          }
        });
  }
}
