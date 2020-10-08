import 'package:flutter/material.dart';
import 'package:scout/pages/match_screen.dart';

// Define a custom Form widget.
class MatchForm extends StatefulWidget {
  @override
  _MatchFormState createState() => _MatchFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _MatchFormState extends State<MatchForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MatchFormState>.
  final _formKey = GlobalKey<FormState>();
  int team1 = 2;
  var team1Color = Colors.red;
  int team2 = 3;
  var team2Color = Colors.red;

  @override
  Widget build(BuildContext context) {
    void goToMatch() {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  new MatchScreen(team1, team1Color, team2, team2Color)));
    }

    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          // Add TextFormFields and RaisedButton here.
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
                goToMatch();
              }
            },
            child: Text('Submit'),
          )
        ]));
  }
}
