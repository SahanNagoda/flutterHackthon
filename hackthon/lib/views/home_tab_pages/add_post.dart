import 'package:custom_multi_image_picker/asset.dart';
import 'package:custom_multi_image_picker/picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackthon/utils/app_model.dart';
import 'package:hackthon/utils/asset_view.dart';
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
  String _error;
  String tagValue;

  final _formKey = GlobalKey<FormState>();
  final _tagKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  String title;
  String description;
  List<Asset> images = List<Asset>();
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blueAccent])),
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 20),
                    child: TextFormField(
                      onSaved: (value) {
                        title = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Title Can't be Empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: TextFormField(
                      onSaved: (value) {
                        description = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Description Can't be Empty";
                        }
                      },
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  images.length > 0 ? buildGridView() : Container(),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: RaisedButton(
                      onPressed: () {
                        loadAssets();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(),
                            flex: 3,
                          ),
                          Expanded(
                            child: Icon(Icons.add_a_photo),
                            flex: 7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text("Add Photos"),
                            flex: 7,
                          ),
                          Expanded(
                            child: SizedBox(),
                            flex: 3,
                          ),
                          Expanded(
                            child: SizedBox(),
                            flex: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: tags.length == 0
                        ? Container(
                            child: Center(
                              child: Text(
                                "Please add Tags",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          )
                        : Row(
                            children: tags
                                .map((item) => Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      height: 25,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            item,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: GestureDetector(
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  tags.remove(item);
                                                });
                                              },
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                    ))
                                .toList()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textController,
                            onChanged: (value) {
                              tagValue = value;
                            },
                            decoration: InputDecoration(
                              labelText: "Add Tag",
                            ),
                          ),
                          flex: 10,
                        ),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                if (tagValue.isNotEmpty) {
                                  setState(() {
                                    tags.add(tagValue);
                                    tagValue = null;
                                    textController.clear();
                                  });
                                }
                              },
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: RaisedButton(
                      onPressed: () {
                        _postButtonAction();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Post",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: _addPost,
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _postButtonAction() {
    if (tags.length == 0) {
    } else {
      print("ok");
      _formKey.currentState.validate();
      _formKey.currentState.save();
    }
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
      print(images);
    });
  }

  Widget buildGridView() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(20),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          return Container(
              margin: EdgeInsets.all(5),
              child: Stack(
                children: <Widget>[
                  AssetView(index, images[index]),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Container(
                        //color: Colors.blue,
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          images.removeAt(index);
                        });
                      },
                    ),
                  )
                ],
              ));
        }),
      ),
    );
  }

  _addPost() async {
    Uuid uuid = Uuid();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<String> images = [];

    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference ref =
        FirebaseStorage.instance.ref().child('posts').child("image.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    images.add(url);

    await Firestore.instance.collection('posts').document(uuid.v1()).setData({
      'title': 'title',
      'author': user.uid,
      'description': 'description',
      'username': user.displayName,
      'time': DateTime.now(),
      'userImage': user.photoUrl,
      'images': images
    });
    List<String> tags = ['tag1', 'tag4'];
    await Firestore.instance
        .collection('tags')
        .document('postTags')
        .updateData({'tags': FieldValue.arrayUnion(tags)});
  }
}
