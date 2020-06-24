import 'package:flutter/material.dart';
import 'package:scout/widgets/draggable_card.dart';

main() {
  runApp(MaterialApp(home: PhysicsCardDragDemo()));
}

class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Stack(children: <Widget>[
      Image(image: AssetImage('assets/img/FutsalPitch.png')),
      DraggableCard(color: Colors.white),
      DraggableCard(color: Colors.red),
      DraggableCard(color: Colors.red),
      DraggableCard(color: Colors.red),
      DraggableCard(color: Colors.red),
      DraggableCard(color: Colors.blue),
      DraggableCard(color: Colors.blue),
      DraggableCard(color: Colors.blue),
      DraggableCard(color: Colors.blue),
    ]));
  }
}
