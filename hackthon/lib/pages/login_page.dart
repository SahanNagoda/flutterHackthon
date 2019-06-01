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
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isLoading;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2,),
            Hero(
              tag: "logo",
              child: CircleAvatar(
                radius: 100.0,
                child: Image.asset(
                  'lib/assets/logo.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  width: 160,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Spacer(),
            Text(
              "Flutter",
              style: TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            ),
            Text(
              "Community",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Spacer(
              flex: 3,
            ),
            
            Container(
              width: 200.0,
              margin: EdgeInsets.all(20.0),
              child: RaisedButton.icon(
                
                color: Colors.white,
                icon: CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "lib/assets/google.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                label: Text("  Login with Google"),
                onPressed: () => _logIn(context),
              ),
              //RaisedButton(
              //   child: Text("Login"),
              //   onPressed: () => _logIn(context),
              // ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
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
