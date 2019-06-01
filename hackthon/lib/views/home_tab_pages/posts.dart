import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:timeago/timeago.dart' as timeago;

class PostsPage extends StatefulWidget {
  final AppModel model;
  @override
  _PostsPageState createState() => _PostsPageState();
  PostsPage(this.model);
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    Firestore.instance.collection('posts').orderBy('time').getDocuments().asStream().listen((data) {
      build(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('posts').getDocuments().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
            List<dynamic> posts = snapshot.data.documents;
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          child: Image.network(posts[index]['userImage']),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          posts[index]['username'],
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      posts[index]['title'],
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                    ),
                                    /* Text(
                                      timeago.format(posts[index]['time']),
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                                    ), */
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            posts[index]['description'],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          posts[index]['images'][0] != null
                              ? Image.network(
                                  posts[index]['images'][0],
                                  width: MediaQuery.of(context).size.width,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('Loading...');
          }
        },
      ),
    );
  }
}
