import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scout/components/round_icon_button.dart';
import 'package:scout/pages/athletes_screen.dart';
import 'package:scout/pages/chat_screen.dart';
import 'package:scout/pages/match_form.dart';
import 'package:scout/pages/team_form.dart';
import 'package:scout/pages/team_list_horizontal.dart';
import 'package:scout/pages/team_screen.dart';
import 'package:scout/pages/welcome_screen.dart';

import 'athlete_form.dart';
import 'athlete_list_horizontal.dart';

User loggedInUser;

class ScoutHome extends StatefulWidget {
  static const String id = 'home';
  @override
  _ScoutHomeState createState() => _ScoutHomeState();
}

class _ScoutHomeState extends State<ScoutHome> {
  final _auth = FirebaseAuth.instance;
  bool hasTeams = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (error) {
      print("Error on getting current user: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scout"),
        elevation: 0.7,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    ),
                  );
                },
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.users),
              title: Text('Times'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sports_handball),
              title: Text('Atletas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AthletesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                _auth.signOut();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PARTIDAS',
                    style: TextStyle(
                      fontFamily: 'BarlowSemiCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Row(
                    children: [
                      FlatButton(
                        child: Text(
                          "VER TODOS",
                        ),
                        onPressed: () {
                          print("clicou em VER TODOS");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => TeamsScreen(),
                          //   ),
                          // );
                        },
                      ),
                      RoundIconButton(
                        colour: Colors.red,
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchForm(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TIMES',
                    style: TextStyle(
                      fontFamily: 'BarlowSemiCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Row(
                    children: [
                      FlatButton(
                        child: Text(
                          "VER TODOS",
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamsScreen(),
                            ),
                          );
                        },
                      ),
                      RoundIconButton(
                        colour: Colors.red,
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamForm(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              TeamsListHorizontal(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ATLETAS',
                    style: TextStyle(
                      fontFamily: 'BarlowSemiCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Row(
                    children: [
                      FlatButton(
                        child: Text(
                          "VER TODOS",
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AthletesScreen(),
                            ),
                          );
                        },
                      ),
                      RoundIconButton(
                        colour: Colors.red,
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AthleteForm(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              AthletesListHorizontal(),
            ],
          ),
        ),
      ),
    );
  }
}
