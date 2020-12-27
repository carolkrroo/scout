import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scout/components/image_picker_button.dart';
import 'package:scout/constants.dart';

import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class TeamForm extends StatefulWidget {
  static const String id = 'team_form';

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  String teamName = '';
  File _image;
  final picker = ImagePicker();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<TeamFormState>.
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  Future getImage() async {
    print('acessou getImage');
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Form"),
        elevation: 0.7,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            ImagePickerButton(),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter the team name', labelText: 'Team name'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  teamName = value;
                  return null;
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _firestore
                      .collection("users")
                      .doc(loggedInUser.email)
                      .collection('teams')
                      .add({
                        'name': teamName,
                      })
                      .then((docRef) =>
                          print("Document written with ID: ${docRef.id}"))
                      .catchError(
                          (error) => print("Error adding document: $error"));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScoutHome(),
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
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                height: kBottomContainerHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
