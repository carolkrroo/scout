import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/components/icon_content.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/pages/athlete_form.dart';

import 'athlete_profile.dart';
import 'home_page.dart';

final _firestore = FirebaseFirestore.instance;

class AthletesListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection("users")
          .doc(loggedInUser.email)
          .collection('athletes')
          .get(),
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
        print('athletes: ${athletes.isEmpty}');
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
                  id: athletes[index].id,
                  name: athletes[index].data()['name'],
                  position: athletes[index].data()['position'],
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
