import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scout/components/image_picker_button.dart';
import 'package:scout/constants.dart';
import 'package:scout/services/location.dart';

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

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<TeamFormState>.
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
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
            GestureDetector(
              // onTap: () => imagePicker.showDialog(context),
              child: Center(
                child: _image == null
                    ? Stack(
                        children: <Widget>[
                          Center(
                            child: new CircleAvatar(
                              radius: 80.0,
                              backgroundColor: const Color(0xFF778899),
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 80.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: new ExactAssetImage(_image.path),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.red, width: 5.0),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
              ),
            ),
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
                  _firestore.collection('teams').add({
                    'name': teamName,
                  });
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
