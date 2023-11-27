import 'package:flutter/material.dart';

class AlarmStopButton extends StatelessWidget {
  final void Function() onPressed;
  const AlarmStopButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 30,
        minimumSize: const Size(300, 50),
        backgroundColor: Theme.of(context).highlightColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      onPressed: onPressed,
      child: const Text("Pause"),
    );
  }
}
