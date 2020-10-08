import 'package:flutter/material.dart';
import 'package:scout/widgets/draggable_card.dart';

class MatchScreen extends StatefulWidget {
  final int team1;
  final Color team1Color;
  final int team2;
  final Color team2Color;

  const MatchScreen(this.team1, this.team1Color, this.team2, this.team2Color);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
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
          Player(Offset(0.0, 100.0), '1', Colors.blue),
          Player(Offset(100.0, 100.0), '2', Colors.lime),
          Player(Offset(200.0, 100.0), '3', Colors.orange),
          Player(Offset(300.0, 100.0), '4', Colors.red),
          ReserveBench(),
        ],
      ),
    );
  }
}

class ReserveBench extends StatefulWidget {
  @override
  _ReserveBenchState createState() => _ReserveBenchState();
}

class _ReserveBenchState extends State<ReserveBench> {
  Color caughtColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100.0,
      bottom: 0.0,
      child: DragTarget(
        onAccept: (Color color) {
          caughtColor = color;
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
            ),
            child: Center(
              child: Text("Drag Here!"),
            ),
          );
        },
      ),
    );
  }
}

Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}
