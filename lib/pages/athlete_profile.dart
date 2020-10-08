import 'package:flutter/material.dart';

class AthleteProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          child: Text('CP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          backgroundImage: AssetImage('assets/img/Krro1.jpg'),
          radius: 70.0,
        ),
        Text(
          'Carolina Pires',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        Text(
          'Goleira'.toUpperCase(),
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
            color: Colors.orange[300],
          ),
        ),
        SizedBox(
          height: 20.0,
          width: 150.0,
          child: Divider(
            color: Colors.orange.shade800,
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                size: 50.0,
                color: Colors.orange.shade500,
              ),
              title: Text(
                '+55 11 98765-4321',
                style: TextStyle(
                    color: Colors.orange.shade500,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(
                Icons.email,
                size: 50.0,
                color: Colors.orange.shade500,
              ),
              title: Text(
                'carol.krroo@gmail.com',
                style: TextStyle(
                    color: Colors.orange.shade500,
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// NetworkImage(
// 'https://pbs.twimg.com/profile_images/529600536551493632/aIrw5Ge7_400x400.jpeg'),
