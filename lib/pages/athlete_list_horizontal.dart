import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/components/icon_content.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/pages/athlete_form.dart';
import 'package:scout/services/athlete_service.dart';

import 'athlete_profile.dart';

class AthletesListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: AthleteService().getAthletes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.orange,
              size: 100.0,
            ),
          );
        }
        final athletes = snapshot.data.docs;
        if (athletes.isEmpty) {
          return ReusableCard(
            backgroundColour: Colors.black12,
            borderColour: Colors.white38,
            cardChild: IconContent(
              icon: Icons.sports_handball,
              label: 'Comece registrando um atleta!',
            ),
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AthleteForm(),
                ),
              );
            },
          );
        } else {
          return Container(
            height: 300.0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AthleteProfile(
                  athleteId: athletes[index].id,
                  name: athletes[index].data()['name'],
                  lastName: athletes[index].data()['last_name'],
                  position: athletes[index].data()['position'],
                  imageUrl: athletes[index].data()['image_url'],
                  teamId: athletes[index].data()['team_id'],
                  gender: athletes[index].data()['gender'],
                );
              },
              itemCount: athletes.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
      },
    );
  }
}
