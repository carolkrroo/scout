import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scout/components/icon_content.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/components/round_icon_button.dart';
import 'package:scout/constants.dart';
import 'package:scout/pages/athletes_screen.dart';
import 'package:scout/pages/match_form.dart';
import 'package:scout/pages/team_form.dart';
import 'package:scout/pages/team_list_horizontal.dart';
import 'package:scout/pages/team_screen.dart';

class ScoutHome extends StatefulWidget {
  static const String id = 'home';

  ScoutHome();

  @override
  _ScoutHomeState createState() => _ScoutHomeState();
}

class _ScoutHomeState extends State<ScoutHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scout"),
        elevation: 0.7,
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TIMES',
                      style: TextStyle(
                        fontFamily: 'BarlowSemiCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      ),
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
                TeamsListHorizontal(),
                Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        backgroundColour: Colors.green,
                        cardChild: IconContent(
                          icon: Icons.settings,
                          label: 'Gerenciar Times',
                        ),
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamsScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        backgroundColour: Colors.lightGreen,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.users,
                          label: 'Gerenciar Atletas',
                        ),
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AthletesScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchForm(),
                      ),
                    );
                  },
                  child: Text(
                    'CRIAR PARTIDA',
                    style: kLargeButtonTextStyle,
                  ),
                  color: kBottomContainerColour,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
