import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

//import './home.dart';

class Login extends StatefulWidget {
  final Widget child;

  Login({Key key, this.child}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

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
                    Hero(
                      tag: "logo",
                      child: Image.asset(
                        'lib/assets/logo.png',
                        width: 250.0,
                        height: 250.0,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    
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

  Future _logIn(BuildContext contexta) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //print(_email.trim() +"-"+_password);
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _email.trim(), password: _password);
        
      } catch (e) {
        print(e.message);
        Scaffold.of(contexta).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
