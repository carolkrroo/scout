import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/pages/team_profile.dart';

final _firestore = FirebaseFirestore.instance;

class TeamsListHorizontal extends StatelessWidget {
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
        List<TeamProfile> teamsProfiles = [];

        for (var team in teams) {
          print('team: $team');
          final teamId = team.data()['id'];
          final teamName = team.data()['name'];

          final teamProfile = TeamProfile(
            id: teamId,
            name: teamName,
          );

          teamsProfiles.add(teamProfile);
        }
        return Container(
          height: 300.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: teamsProfiles,
          ),
        );
      },
    );
  }
}
