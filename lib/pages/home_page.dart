import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/constants.dart';
import 'package:scout/pages/match_form.dart';

class ScoutHome extends StatefulWidget {
  static const String id = 'home';

  ScoutHome();

  @override
  _ScoutHomeState createState() => _ScoutHomeState();
}

class _ScoutHomeState extends State<ScoutHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scout"),
        elevation: 0.7,
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SpinKitChasingDots(
                color: Colors.orange,
                size: 100.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchForm(),
                    ),
                  );
                },
                child: Text(
                  'CRIAR PARTIDA',
                  style: kLargeButtonTextStyle,
                ),
                color: kBottomContainerColour,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
