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
  String _error;
  bool loading = false;
  String tagValue;

  final _formKey = GlobalKey<FormState>();
  final _tagKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  String title;
  String description;
  List<String> tags = [];
  File image;
  String imageUrl;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.lightBlue, Colors.blue])),
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
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
                      style: TextStyle(fontSize: 18),
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      image == null && imageUrl == null
                          ? Expanded(
                              child: RaisedButton(
                                onPressed: getImage,
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Add image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: imageUrl == null
                                  ? Center(child: CircularProgressIndicator())
                                  : Stack(
                                      children: <Widget>[
                                        Image.network(imageUrl, width: MediaQuery.of(context).size.width),
                                        Positioned(
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () => setState(() {
                                                  imageUrl = null;
                                                  image = null;
                                                }),
                                          ),
                                          right: 10,
                                          top: 10,
                                        ),
                                      ],
                                    ),
                            ),

                      // SizedBox(
                      //   width: 20,
                      // ),
                      // Text('or'),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      // Expanded(
                      //   child: RaisedButton(
                      //     onPressed: getImage,
                      //     color: Colors.red,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Text(
                      //           'Add video',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //         SizedBox(
                      //           width: 5,
                      //         ),
                      //         Icon(
                      //           Icons.video_library,
                      //           color: Colors.white,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
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
                        : Container(
                            height: 28,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: tags
                                  .map((item) => Container(
                                        margin: EdgeInsets.only(left: 5, right: 5),
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                                      ))
                                  .toList(),
                            ),
                          ),
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
                          loading
                              ? CircularProgressIndicator()
                              : Expanded(
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
    setState(() {
      loading = true;
    });
    if (tags.length == 0) {
    } else {
      print("ok");
      _formKey.currentState.validate();
      _formKey.currentState.save();
    }
    _addPost();
  }

  getImage() async {
    Uuid uuid = Uuid();
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference ref = FirebaseStorage.instance.ref().child('posts').child(uuid.v1());
    StorageUploadTask uploadTask = ref.putFile(img);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    setState(() {
      imageUrl = url;
      image = img;
    });
  }

  _addPost() async {
    Uuid uuid = Uuid();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<String> imagesStrings = [];

    imagesStrings.add(imageUrl);

    await Firestore.instance.collection('posts').document(uuid.v1()).setData({
      'title': title,
      'author': user.uid,
      'description': description,
      'username': user.displayName,
      'time': DateTime.now(),
      'userImage': user.photoUrl,
      'images': imagesStrings,
    });
    List<String> tags_ = tags;
    await Firestore.instance.collection('tags').document('postTags').updateData({'tags': FieldValue.arrayUnion(tags_)});
    widget.model.setHomeTabState(1);
    setState(() {
      loading = false;
    });
  }
}
