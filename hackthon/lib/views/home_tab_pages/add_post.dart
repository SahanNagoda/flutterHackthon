import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends StatefulWidget {
  final AppModel model;
  @override
  _AddPostPageState createState() => _AddPostPageState();

  AddPostPage(this.model);
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(
        onPressed: _addPost,
        child: Text('Add'),
      ),
    );
  }

  _addPost() async {
    Uuid uuid = Uuid();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<String> images = [];

    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference ref = FirebaseStorage.instance.ref().child('posts').child("image.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    images.add(url);

    await Firestore.instance.collection('posts').document(uuid.v1()).setData(
        {'title': 'title', 'author': user.uid, 'description': 'description', 'username': user.displayName, 'time': DateTime.now(), 'userImage': user.photoUrl, 'images': images});
    List<String> tags = ['tag1', 'tag4'];
    await Firestore.instance.collection('tags').document('postTags').updateData({'tags': FieldValue.arrayUnion(tags)});
  }
}
