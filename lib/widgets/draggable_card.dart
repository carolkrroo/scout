import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  Player(this.initPos, this.label, this.itemColor);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Offset position = Offset(0.0, 0.0);
  double size = 70.0;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    print(position);
    return Positioned(
      left: position.dx,
      top: position.dy - (size + 10.0),
      child: Draggable(
        data: widget.itemColor,
        child: Card(
          color: widget.itemColor,
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
        childWhenDragging: Card(
          shape: StadiumBorder(),
        ),
        feedback: Card(
          color: widget.itemColor,
          shape: StadiumBorder(
            side: BorderSide(
              color: darken(widget.itemColor, 30),
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
          setState(() {
            position = offset;
          });
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
