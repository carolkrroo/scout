import 'package:flutter/material.dart';

class TargetCard extends StatefulWidget {
  final String label;
  final Color color;

  TargetCard({this.color, this.label});

  @override
  _TargetCardState createState() => _TargetCardState();
}

class _TargetCardState extends State<TargetCard> {
  Color caughtColor;
  String caughtLabel;
  double size = 70.0;

  void initState() {
    super.initState();
    caughtColor = widget.color;
    caughtLabel = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: DragTarget(
        onWillAccept: (data) {
          print('onWillAccept: $data');
          return true;
        },
        onAccept: (List data) {
          print('onAccept: $data');
          if (data.length == 2) {
            caughtColor = data[0];
            caughtLabel = data[1];
          }
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: accepted.isEmpty
                    ? Colors.transparent
                    : darken(widget.color, 30),
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(caughtLabel),
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
