import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import 'zero_mode.dart';

class ZeroModeSetup extends StatelessWidget {
  const ZeroModeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Column(
            children: const [
              Text(
                "영충 누적 시간",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "00 : 00 ",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v20,
              ZeroModeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
