import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/components/round_icon_button.dart';
import 'package:scout/pages/team_form.dart';
import 'package:scout/pages/team_profile.dart';

final _firestore = FirebaseFirestore.instance;

class TeamsScreen extends StatefulWidget {
  static const String id = 'teams_screen';
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
        elevation: 0.7,
        actions: <Widget>[
          RoundIconButton(
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TeamsList(),
          ],
        ),
      ),
    );
  }
}

// NetworkImage(
// 'https://pbs.twimg.com/profile_images/529600536551493632/aIrw5Ge7_400x400.jpeg'),
class TeamsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore.collection('teams').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.orange,
              size: 100.0,
            ),
          );
        }

        final teams = snapshot.data.docs;

        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TeamProfile(
                id: teams[index].id,
                name: teams[index].data()['name'],
              );
            },
            itemCount: teams.length,
          ),
        );
      },
    );
  }
}
