import 'package:flutter/material.dart';
import 'package:scout/components/draggable_card.dart';
import 'package:scout/components/reusable_card.dart';
import 'package:scout/components/target_card.dart';
import 'package:scout/services/page_orientation.dart';
import 'package:scout/team.dart';

import '../constants.dart';

class MatchScreen extends StatefulWidget {
  final Team team1;
  final Team team2;

  const MatchScreen(this.team1, this.team2);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  String selectedDefense;

  List<Widget> players = [
    DraggableCard(initPos: Offset(0.0, 100.0), label: '1', color: Colors.blue),
    DraggableCard(
        initPos: Offset(100.0, 100.0), label: '2', color: Colors.lime),
    DraggableCard(
        initPos: Offset(200.0, 100.0), label: '3', color: Colors.orange),
    DraggableCard(initPos: Offset(300.0, 100.0), label: '4', color: Colors.red),
  ];

  List<Widget> reservePlayers = [
    TargetCard(
      label: '31',
      color: Colors.red,
    ),
    TargetCard(
      label: '32',
      color: Colors.red,
    ),
    TargetCard(
      label: '34',
      color: Colors.red,
    )
  ];

  @override
  void initState() {
    super.initState();
    PageOrientation().landscapeModeOnly();
  }

  @override
  void dispose() {
    super.dispose();
    PageOrientation().enableRotation();
  }

  @override
  Widget build(BuildContext context) {
    print('team1: ${widget.team1.name}');
    print('team1: ${widget.team2.name}');
    return Scaffold(
      appBar: AppBar(
        title: Text("Match"),
        elevation: 0.7,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Formação defensiva'),
                  Row(
                    children: <Widget>[
                      ReusableCard(
                        colour: selectedDefense == '6:0'
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '6:0',
                            style: kLabelTextStyle,
                          ),
                        ),
                        onPress: () {
                          setState(() {
                            selectedDefense = '6:0';
                            print(selectedDefense);
                          });
                        },
                      ),
                      ReusableCard(
                        colour: selectedDefense == '5:1'
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '5:1',
                            style: kLabelTextStyle,
                          ),
                        ),
                        onPress: () {
                          setState(() {
                            selectedDefense = '5:1';
                            print(selectedDefense);
                          });
                        },
                      ),
                      ReusableCard(
                        colour: selectedDefense == '4:2'
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '4:2',
                            style: kLabelTextStyle,
                          ),
                        ),
                        onPress: () {
                          setState(() {
                            selectedDefense = '4:2';
                            print(selectedDefense);
                          });
                        },
                      ),
                      ReusableCard(
                        colour: selectedDefense == '5+1'
                            ? kActiveCardColour
                            : kInactiveCardColour,
                        cardChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '5+1',
                            style: kLabelTextStyle,
                          ),
                        ),
                        onPress: () {
                          setState(() {
                            selectedDefense = '5+1';
                            print(selectedDefense);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Punições'),
                  Row(
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {
                          print('7m');
                        },
                        child: Text('7m'),
                      ),
                      OutlineButton(
                        onPressed: () {
                          print('2\'\'');
                        },
                        child: Text('2\'\''),
                      ),
                      OutlineButton(
                        onPressed: () {
                          print('amarelo');
                        },
                        child: SizedBox(
                          width: 20.0,
                          height: 30.0,
                          child: Container(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {
                          print('vermelho');
                        },
                        child: SizedBox(
                          width: 20.0,
                          height: 30.0,
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {
                          print('azul');
                        },
                        child: SizedBox(
                          width: 20.0,
                          height: 30.0,
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/HandballPitch.jpg'),
              ),
              // DragTarget<Color>(
              //   onWillAccept: (value) => value != Colors.black,
              //   builder: (context, candidates, rejects) {
              //     return candidates.length > 0 ? Text('é maior') : Text('é menor');
              //   },
              // ),
              // Draggable<Color>(
              //   data: Color(0x000000ff),
              //   child: Text('testando'),
              //   childWhenDragging: Text('dragging'),
              // ),
              DraggableCard(
                  initPos: Offset(0.0, 0.0), label: '1', color: Colors.blue),
              DraggableCard(
                  initPos: Offset(100.0, 0.0), label: '2', color: Colors.lime),
              DraggableCard(
                  initPos: Offset(200.0, 0.0),
                  label: '3',
                  color: Colors.orange),
              DraggableCard(
                  initPos: Offset(300.0, 0.0), label: '4', color: Colors.red),
              DraggableCard(
                  initPos: Offset(400.0, 0.0), label: '8', color: Colors.blue),
              DraggableCard(
                  initPos: Offset(500.0, 0.0), label: '9', color: Colors.lime),
              DraggableCard(
                  initPos: Offset(600.0, 0.0),
                  label: '10',
                  color: Colors.orange),
              DraggableCard(
                  initPos: Offset(700.0, 0.0), label: '11', color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.brown,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: reservePlayers,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.brown,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: reservePlayers,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
