import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scout/components/icon_content.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/pages/team_form.dart';
import 'package:scout/pages/team_profile.dart';
import 'package:scout/services/team_service.dart';

class TeamsListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: TeamService().getTeams(),
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
        if (teams.isEmpty) {
          return ReusableCard(
            backgroundColour: Colors.white38,
            borderColour: Colors.white38,
            cardChild: IconContent(
              icon: FontAwesomeIcons.users,
              label: 'Comece registrando um time!',
            ),
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamForm(),
                ),
              );
            },
          );
        } else {
          return Container(
            height: 300.0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TeamProfile(
                    teamId: teams[index].id,
                    name: teams[index].data()['name'],
                    imageUrl: teams[index].data()['image_url']);
              },
              itemCount: teams.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
      },
    );
  }
}
