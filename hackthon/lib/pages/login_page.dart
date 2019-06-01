import 'package:flutter/material.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  final AppModel model;
  @override
  _LoginPageState createState() => _LoginPageState();
  LoginPage(this.model);
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Builder(
          builder: (context) => Container(
                margin: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    
                    
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        child: Text("Login"),
                        onPressed: () => _logIn(context),
                      ),
                    )
                  ],
                ),
              ),
        ));
  }
}

Future _logIn(BuildContext contexta) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //print(_email.trim() +"-"+_password);
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  try {
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
  } catch (e) {
    print(e.message);
    Scaffold.of(contexta).showSnackBar(SnackBar(content: Text(e.message)));
  }
}
