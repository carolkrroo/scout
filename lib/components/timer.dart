import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Timer extends StatefulWidget {
  final int presetTime;

  Timer({this.presetTime});

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    // _stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));

    if (widget.presetTime != null) {
      _stopWatchTimer.setPresetTime(mSec: widget.presetTime);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value, hours: false);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        RawMaterialButton(
          child: Icon(
            _stopWatchTimer.isRunning ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _stopWatchTimer.isRunning
                  ? _stopWatchTimer.onExecute.add(StopWatchExecute.stop)
                  : _stopWatchTimer.onExecute.add(StopWatchExecute.start);
            });
          },
          elevation: 6.0,
          constraints: BoxConstraints.tightFor(
            width: 40.0,
            height: 40.0,
          ),
          shape: CircleBorder(),
          fillColor: Colors.orange,
        ),
      ],
    );
  }
}
