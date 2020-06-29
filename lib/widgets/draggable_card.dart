import 'package:flutter/material.dart';

class DraggableCard extends StatefulWidget {
  final Color color;

  const DraggableCard({this.color});

  @override
  State createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment> _animation;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _selected = _selected;
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
        setState(() {
          _selected = true;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        setState(() {
          _selected = false;
        });
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
            color: widget.color,
            shape: StadiumBorder(
              side: BorderSide(
                color:
                    _selected ? darken(widget.color, 40) : Colors.transparent,
                width: 2.0,
              ),
            ),
            elevation: _selected ? 5 : 0,
            child: Container(
              width: 30,
              height: 30,
            )),
      ),
    );
  }

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }
}
