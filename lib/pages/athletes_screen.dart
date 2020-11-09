import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scout/components/round_icon_button.dart';
import 'package:scout/pages/athlete_form.dart';
import 'package:scout/pages/athlete_profile.dart';

final _firestore = FirebaseFirestore.instance;

class AthletesScreen extends StatefulWidget {
  static const String id = 'athletes_screen';
  @override
  _AthletesScreenState createState() => _AthletesScreenState();
}

class _AthletesScreenState extends State<AthletesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Athletes"),
        elevation: 0.7,
        actions: <Widget>[
          RoundIconButton(
              icon: Icons.add,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AthleteForm(),
                  ),
                );
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AthletesList(),
            ]),
      ),
    );
  }
}

// NetworkImage(
// 'https://pbs.twimg.com/profile_images/529600536551493632/aIrw5Ge7_400x400.jpeg'),
class AthletesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore.collection('athletes').get(),
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
        List<AthleteProfile> athleteProfiles = [];

        for (var athlete in athletes) {
          print('athlete: $athlete');
          final athleteName = athlete.data()['name'];
          final athletePosition = athlete.data()['position_id'];

          final athleteProfile = AthleteProfile(
            name: athleteName,
            position: athletePosition,
          );

          athleteProfiles.add(athleteProfile);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: athleteProfiles,
          ),
        );
      },
    );
  }
}
