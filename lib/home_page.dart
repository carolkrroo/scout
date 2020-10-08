import 'package:flutter/material.dart';
import 'package:scout/pages/match_screen.dart';

class ScoutHome extends StatefulWidget {
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
        child: MatchScreen(7, Colors.red, 7, Colors.blue),
      ),
    );
  }
}
