import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class Timer extends StatefulWidget {
  final int timeBase;

  const Timer({
    super.key,
    required this.timeBase,
  });

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  late DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.scheduled(
      [alert],
      builder: (context) {
        // This function will be called once the alert time is reached
        var now = DateTime.now();
        var reached = now.compareTo(alert) >= 0;
        final textStyle = Theme.of(context).textTheme.bodyMedium;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                reached ? Icons.alarm_on : Icons.alarm,
                color: reached ? Colors.red : Colors.green,
                size: 200,
              ),
              !reached
                  ? TimerBuilder.periodic(const Duration(seconds: 1),
                      alignment: Duration.zero, builder: (context) {
                      // This function will be called every second until the alert time
                      var now = DateTime.now();
                      var remaining = alert.difference(now);
                      return Text(
                        formatDuration(remaining),
                        style: textStyle,
                      );
                    })
                  : Text("Alert", style: textStyle),
              ElevatedButton(
                child: const Text("Reset"),
                onPressed: () {
                  setState(() {
                    alert =
                        DateTime.now().add(Duration(seconds: widget.timeBase));
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  // We want to round up the remaining time to the nearest second
  d += const Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
