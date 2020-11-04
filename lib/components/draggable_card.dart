import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color color;

  DraggableCard({Key key, this.initPos, this.label, this.color})
      : super(key: key);

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  Offset position;
  double size = 70.0;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    print('Build Draggable Card: $position');
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: [
          widget.color,
          widget.label,
        ],
        child: Card(
          color: widget.color,
          shape: StadiumBorder(),
          child: Container(
            width: size,
            height: size,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
        childWhenDragging: Container(),
        feedback: Card(
          color: widget.color,
          shape: StadiumBorder(
            side: BorderSide(
              color: darken(widget.color, 30),
              width: 2.0,
            ),
          ),
          elevation: 5,
          child: Container(
            width: size,
            height: size,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          print('onDraggableCanceled');
          setState(() {
            print('onDraggableCanceled position: $offset');
            position = offset;
          });
        },
        onDragCompleted: () {
          print('onDragCompleted');
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
