import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.backgroundColour,
      this.borderColour,
      this.cardChild,
      this.onPress});

  final Color backgroundColour;
  final Color borderColour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: backgroundColour,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: borderColour == null ? Colors.transparent : borderColour,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
