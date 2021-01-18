import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed, this.colour});

  final IconData icon;
  final Function onPressed;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 32.0,
        height: 32.0,
      ),
      shape: CircleBorder(),
      fillColor: colour,
    );
  }
}
