import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scout/constants.dart';
import 'package:scout/team.dart';

import 'match_screen.dart';

class MatchForm extends StatefulWidget {
  static const String id = 'match_form';

  @override
  _MatchFormState createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Criar Partida"),
        elevation: 0.7,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  Team team1 = Team(name: 'FAU');
                  Team team2 = Team(name: 'USP');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchScreen(team1, team2),
                    ),
                  );
                }
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Iniciar Partida',
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
