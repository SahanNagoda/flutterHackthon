import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileTab extends StatefulWidget {
  final AppModel model;

  @override
  _ProfileTabState createState() => _ProfileTabState();

  ProfileTab(this.model, {Key key}) : super(key: key);
}

class _ProfileTabState extends State<ProfileTab> {
  FirebaseUser user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  doAsyncStuff() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      this.user = user;
    });
  }

  Future<FirebaseUser> _getCurrentUserName() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: FutureBuilder(
          future: _getCurrentUserName(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return new Text(snapshot.data.toString());
            else
              return new Container();
          },
        )),
        FlatButton(
          child: Text("Sign Out"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ],
    );
  }
}
