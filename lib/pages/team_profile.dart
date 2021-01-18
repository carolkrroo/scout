import 'package:flutter/material.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/pages/team_form.dart';

class TeamProfile extends StatelessWidget {
  static const String id = 'team_profile';

  TeamProfile(
      {@required this.teamId, @required this.name, @required this.imageUrl});

  final String teamId;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      backgroundColour: Colors.white38,
      borderColour: Colors.indigo,
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamForm(
              teamId: teamId,
              name: name,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              backgroundImage:
                  NetworkImage(imageUrl + '&' + DateTime.now().toString()),
              radius: 70.0,
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'BarlowSemiCondensed',
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
