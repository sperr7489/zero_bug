import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/gaps.dart';
import '../../../providers/memo_model.dart';
import 'zero_mode.dart';

class ZeroModeSetupContainer extends StatefulWidget {
  const ZeroModeSetupContainer({super.key});

  @override
  State<ZeroModeSetupContainer> createState() => _ZeroModeSetupContainerState();
}

class _ZeroModeSetupContainerState extends State<ZeroModeSetupContainer> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode myFocusNode;
  late MemoModel memoModel;

  // String memo = "";
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    memoModel = context.read<MemoModel>();

    _controller.addListener(() {
      memoModel.setContent = _controller.text;
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

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
            children: [
              const Text(
                "Zero Mode Setup",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Gaps.v10,
              SizedBox(
                width: 350,
                child: TextField(
                  focusNode: myFocusNode,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: TextInputType.text,
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "지금 바로 집중하지 않는 이유",
                    hintStyle: TextStyle(
                      letterSpacing: 2,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    labelText: "memo",
                  ),
                ),
              ),
              Gaps.v20,
              const ZeroModeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
