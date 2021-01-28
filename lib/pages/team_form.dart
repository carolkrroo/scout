import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scout/components/image_picker_button.dart';
import 'package:scout/components/rounded_button.dart';
import 'package:scout/models/team.dart';

import '../constants.dart';
import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class TeamForm extends StatefulWidget {
  static const String id = 'team_form';

  TeamForm({this.teamId, this.name, this.imageUrl});

  final String teamId;
  final String name;
  final String imageUrl;

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  var _team = Team();
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instanceFor(
          bucket: 'gs://scout-d7c93.appspot.com');
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    _team.teamId = widget.teamId;
    _team.name = widget.name;
    _team.imageUrl = widget.imageUrl;
  }

  _showSnackBar(String message) {
    var _snackBar = SnackBar(
      content: Text(message),
    );
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(_team.teamId == null ? "Registrar Time" : "Editar Time"),
        elevation: 0.7,
      ),
      body: Form(
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
                      dialogLabel: 'Escudo do Time',
                      imageUrl: _team.imageUrl,
                      onFileCropped: (value) {
                        setState(() {
                          _team.image = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Insira o nome do Time',
                          labelText: 'Nome do Time',
                        ),
                        keyboardType: TextInputType.text,
                        initialValue: widget.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          setState(() {
                            _team.name = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: RoundedButton(
                    title: 'Salvar',
                    colour: Colors.indigo,
                    onPressed: () async {
                      if (_formKey.currentState.validate() &&
                          (_team.image != null || _team.imageUrl != null)) {
                        _formKey.currentState.save();
                        try {
                          if (_team.teamId == null) {
                            DocumentReference docRef = await _firestore
                                .collection("users")
                                .doc(loggedInUser.email)
                                .collection('teams')
                                .add(
                              {
                                'name': _team.name,
                                'created_at': DateTime.now(),
                              },
                            );
                            setState(() {
                              _team.teamId = docRef.id;
                            });
                          }
                          if (_team.image != null) {
                            await _storage
                                .ref()
                                .child(_team.teamId)
                                .putFile(_team.image);
                          }
                          await _firestore
                              .collection("users")
                              .doc(loggedInUser.email)
                              .collection("teams")
                              .doc(_team.teamId)
                              .update(
                            {
                              'updated_at': DateTime.now(),
                              'name': _team.name,
                              "image_url":
                                  'https://firebasestorage.googleapis.com/v0/b/scout-d7c93.appspot.com/o/${_team.teamId}?alt=media',
                            },
                          );
                        } on firebase_storage.FirebaseException catch (error) {
                          print("Erro ao salvar o Time: $error");
                          _showSnackBar('Erro ao salvar o Time.');
                        } finally {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScoutHome(),
                            ),
                          );
                        }
                      } else {
                        _showSnackBar('Preencha os campos obrigatórios.');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
