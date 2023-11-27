import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';

class TimerProgressIndicator extends StatefulWidget {
  const TimerProgressIndicator({super.key});

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "현재 진행되는 시간",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Gaps.v32,
          CircularProgressIndicator(
            value: controller.value,
          ),
          Gaps.v32,
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'determinate Mode',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Switch(
                value: determinate,
                onChanged: (bool value) {
                  setState(() {
                    determinate = value;
                    if (determinate) {
                      controller.stop();
                    } else {
                      controller
                        ..forward(from: controller.value)
                        ..repeat();
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
