import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scout/components/icon_content.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/components/round_icon_button.dart';
import 'package:scout/constants.dart';
import 'package:scout/enums/gender.enum.dart';
import 'package:scout/enums/players-positions.enum.dart';
import 'package:scout/services/location.dart';

import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class AthleteForm extends StatefulWidget {
  static const String id = 'athlete_form';

  @override
  _AthleteFormState createState() => _AthleteFormState();
}

class _AthleteFormState extends State<AthleteForm> {
  Gender selectedGender = Gender.female;
  String name = '';
  String lastName = '';
  int height = 180;
  int weight = 60;
  int age = 18;
  PlayersPositions position = PlayersPositions.goalkeeper;
  String teamId = 'CSKA';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<AthleteFormState>.
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
        title: Text("Athlete Form"),
        elevation: 0.7,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'NAME',
                          style: kLabelTextStyle,
                        ),
                        TextField(
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter the athlete name'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'LAST NAME',
                          style: kLabelTextStyle,
                        ),
                        TextField(
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            lastName = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter the athlete last name'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Posição',
                  style: TextStyle(
                    fontFamily: 'BarlowSemiCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                DropdownButton<PlayersPositions>(
                  value: position,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  onChanged: (PlayersPositions newValue) {
                    setState(() {
                      position = newValue;
                    });
                  },
                  items: PlayersPositions.values
                      .map<DropdownMenuItem<PlayersPositions>>(
                          (PlayersPositions value) {
                    return DropdownMenuItem<PlayersPositions>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Time',
                  style: TextStyle(
                    fontFamily: 'BarlowSemiCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                DropdownButton<String>(
                  value: teamId,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      teamId = newValue;
                    });
                  },
                  items: <String>['CSKA', 'GYÖRI AUDI ETO KC']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      backgroundColour: selectedGender == Gender.male
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'MALE',
                      ),
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      backgroundColour: selectedGender == Gender.female
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        label: 'FEMALE',
                      ),
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                backgroundColour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      backgroundColour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      backgroundColour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _firestore
                      .collection("users")
                      .doc(loggedInUser.email)
                      .collection('athletes')
                      .add({
                        'name': name,
                        'last_name': lastName,
                        'gender': selectedGender.toString(),
                        'height': height,
                        'position': position.toString(),
                        'team_id': teamId,
                        'weight': weight
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
