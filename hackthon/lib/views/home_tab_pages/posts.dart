import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
      onPressed: _addPost(),
    ));
  }

  _addPost() async {
    Firestore.instance.collection('books').document().setData({'title': 'title', 'author': 'author'});
  }
}
