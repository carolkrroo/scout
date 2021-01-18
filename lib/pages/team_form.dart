import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scout/components/image_picker_button.dart';

import '../constants.dart';
import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class TeamForm extends StatefulWidget {
  static const String id = 'team_form';

  TeamForm({this.teamId, this.name, this.imageUrl});

  String teamId;
  String name;
  String imageUrl;

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  File image;
  final picker = ImagePicker();
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instanceFor(
          bucket: 'gs://scout-d7c93.appspot.com');

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Form"),
        elevation: 0.7,
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ImagePickerButton(
                        imageUrl: widget.imageUrl,
                        onFileCropped: (value) {
                          setState(() {
                            image = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter the team name',
                            labelText: 'Team name',
                          ),
                          keyboardType: TextInputType.text,
                          initialValue: widget.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            widget.name = value;
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate() &&
                          (image != null || widget.imageUrl != null)) {
                        try {
                          if (widget.teamId == null) {
                            DocumentReference docRef = await _firestore
                                .collection("users")
                                .doc(loggedInUser.email)
                                .collection('teams')
                                .add(
                              {
                                'name': widget.name,
                                'created_at': DateTime.now(),
                              },
                            );
                            setState(() {
                              widget.teamId = docRef.id;
                            });
                          }
                          if (image != null) {
                            await _storage
                                .ref()
                                .child(widget.teamId)
                                .putFile(image);
                          }
                          await _firestore
                              .collection("users")
                              .doc(loggedInUser.email)
                              .collection("teams")
                              .doc(widget.teamId)
                              .update(
                            {
                              'updated_at': DateTime.now(),
                              'name': widget.name,
                              "imageUrl":
                                  'https://firebasestorage.googleapis.com/v0/b/scout-d7c93.appspot.com/o/${widget.teamId}?alt=media',
                            },
                          );
                        } on firebase_storage.FirebaseException catch (e) {
                          print("Erro ao salvar o Time: $e");
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao salvar o Time.'),
                            ),
                          );
                        } finally {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScoutHome(),
                            ),
                          );
                        }
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Todos os campos devem ser preenchidos.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Submit',
                          style: kLargeButtonTextStyle,
                        ),
                      ),
                      color: kBottomContainerColour,
                      margin: EdgeInsets.only(top: 8.0),
                      width: double.infinity,
                      height: kBottomContainerHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
