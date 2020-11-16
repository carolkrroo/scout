import 'package:flutter/material.dart';
import 'package:scout/components/reusable_card.dart';

class TeamProfile extends StatelessWidget {
  TeamProfile({@required this.id, @required this.name});

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      borderColour: Colors.indigo,
      onPress: () {
        print('selecionou: $id');
      },
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              child: Text('CP',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              backgroundImage: AssetImage('assets/img/Krro1.jpg'),
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
// NetworkImage(
// 'https://pbs.twimg.com/profile_images/529600536551493632/aIrw5Ge7_400x400.jpeg'),
