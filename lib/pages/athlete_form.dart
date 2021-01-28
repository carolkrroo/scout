import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scout/components/image_picker_button.dart';
import 'package:scout/components/rounded_button.dart';
import 'package:scout/constants.dart';
import 'package:scout/enums/gender.enum.dart';
import 'package:scout/enums/players-positions.enum.dart';
import 'package:scout/models/athlete.dart';
import 'package:scout/services/team_service.dart';

import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class AthleteForm extends StatefulWidget {
  static const String id = 'athlete_form';

  AthleteForm({
    this.athleteId,
    this.name,
    this.lastName,
    this.imageUrl,
    this.position,
    this.teamId,
    this.gender,
  });

  final String athleteId;
  final String name;
  final String lastName;
  final String imageUrl;
  final String position;
  final String teamId;
  final String gender;

  @override
  _AthleteFormState createState() => _AthleteFormState();
}

class _AthleteFormState extends State<AthleteForm> {
  var _athlete = Athlete();
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instanceFor(
          bucket: 'gs://scout-d7c93.appspot.com');
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem> _positions = List<DropdownMenuItem>();
  List<DropdownMenuItem> _teams = List<DropdownMenuItem>();
  List<DropdownMenuItem> _genders = List<DropdownMenuItem>();

  void initState() {
    super.initState();
    _loadTeams();
    _loadPositions();
    _loadGenders();
    _athlete.athleteId = widget.athleteId;
    _athlete.name = widget.name;
    _athlete.lastName = widget.lastName;
    _athlete.imageUrl = widget.imageUrl;
    _athlete.position = widget.position;
    _athlete.gender = widget.gender;
  }

  _loadTeams() async {
    var teams = await TeamService().getTeamsList();
    teams.forEach((value) {
      _teams.add(DropdownMenuItem(
        child: Text(value.data()['name']),
        value: value.id,
      ));
    });
    setState(() {
      _athlete.teamId = widget.teamId;
    });
  }

  _loadPositions() async {
    PlayersPositions.values.forEach((value) {
      _positions.add(DropdownMenuItem(
        child: Text(PlayersPositionsName[value]),
        value: describeEnum(value),
      ));
    });
  }

  _loadGenders() async {
    Gender.values.forEach((value) {
      _genders.add(DropdownMenuItem(
        child: Text(GenderName[value]),
        value: describeEnum(value),
      ));
    });
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
        title: Text(
            _athlete.athleteId == null ? "Registrar Atleta" : "Editar Atleta"),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ImagePickerButton(
                        dialogLabel: 'Foto de perfil',
                        imageUrl: _athlete.imageUrl,
                        onFileCropped: (value) {
                          setState(() {
                            _athlete.image = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Insira o primeiro nome do atleta',
                                  labelText: 'Nome',
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
                                    _athlete.name = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
                              child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Insira o sobrenome do atleta',
                                  labelText: 'Sobrenome',
                                ),
                                keyboardType: TextInputType.text,
                                initialValue: widget.lastName,
                                onSaved: (String value) {
                                  setState(() {
                                    _athlete.lastName = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                              child: DropdownButtonFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Gênero',
                                ),
                                value: _athlete.gender,
                                items: _genders,
                                onChanged: (value) {
                                  setState(() {
                                    _athlete.gender = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
                              child: DropdownButtonFormField(
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Posição',
                                ),
                                value: widget.position,
                                items: _positions,
                                onChanged: (value) {
                                  setState(() {
                                    _athlete.position = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Time',
                          ),
                          value: _athlete.teamId,
                          items: _teams,
                          onChanged: (value) {
                            setState(() {
                              _athlete.teamId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     ReusableCard(
                      //       backgroundColour: _athlete.gender == Gender.male
                      //           ? kActiveCardColour
                      //           : kInactiveCardColour,
                      //       cardChild: IconContent(
                      //         icon: FontAwesomeIcons.mars,
                      //         label: 'MALE',
                      //       ),
                      //       onPress: () {
                      //         setState(() {
                      //           _athlete.gender = Gender.male.toString();
                      //         });
                      //       },
                      //     ),
                      //     ReusableCard(
                      //       backgroundColour: _athlete.gender == Gender.female
                      //           ? kActiveCardColour
                      //           : kInactiveCardColour,
                      //       cardChild: IconContent(
                      //         icon: FontAwesomeIcons.venus,
                      //         label: 'FEMALE',
                      //       ),
                      //       onPress: () {
                      //         setState(() {
                      //           _athlete.gender = Gender.female.toString();
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: RoundedButton(
                    title: 'Salvar',
                    colour: Colors.indigo,
                    onPressed: () async {
                      if (_formKey.currentState.validate() &&
                          (_athlete.image != null ||
                              _athlete.imageUrl != null)) {
                        _formKey.currentState.save();
                        try {
                          if (widget.athleteId == null) {
                            DocumentReference docRef = await _firestore
                                .collection("users")
                                .doc(loggedInUser.email)
                                .collection('athletes')
                                .add(
                              {
                                'created_at': DateTime.now(),
                                'name': widget.name,
                                'last_name': widget.lastName,
                                'gender': _athlete.gender,
                                'position': widget.position,
                                'team_id': widget.teamId,
                              },
                            );
                            setState(() {
                              _athlete.athleteId = docRef.id;
                            });
                          }
                          if (_athlete.image != null) {
                            await _storage
                                .ref()
                                .child(widget.athleteId)
                                .putFile(_athlete.image);
                          }
                          await _firestore
                              .collection("users")
                              .doc(loggedInUser.email)
                              .collection("athletes")
                              .doc(_athlete.athleteId)
                              .update(
                            {
                              'updated_at': DateTime.now(),
                              'name': _athlete.name,
                              'last_name': _athlete.lastName,
                              'gender': _athlete.gender,
                              'position': _athlete.position,
                              'team_id': _athlete.teamId,
                              "image_url":
                                  'https://firebasestorage.googleapis.com/v0/b/scout-d7c93.appspot.com/o/${_athlete.athleteId}?alt=media',
                            },
                          );
                        } on firebase_storage.FirebaseException catch (error) {
                          print("Erro ao salvar Atleta: $error");
                          _showSnackBar('Erro ao salvar Atleta.');
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
