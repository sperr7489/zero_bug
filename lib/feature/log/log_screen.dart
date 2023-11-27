import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/memo.dart';
import '../../providers/zero_base_model.dart';
import '../../service/memo_service.dart';
import 'widget/alarm_log_card.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  late Future<List<Memo>> memos;
  late ZeroBaseModel zeroBaseModel;
  @override
  void initState() {
    super.initState();
    zeroBaseModel = context.read<ZeroBaseModel>();

    memos = MemoService.getMemosByDate(
      zeroBaseModel.lastDate,
    );
  }

  @override
  void didChangeDependencies() {
    // ZeroBaseModel를 지켜보고 있다면 변화가 생기면 아래의 memos를 새롭게 추가해줘야한다.
    ZeroBaseModel zeroBaseModel = context.watch<ZeroBaseModel>();
    if (zeroBaseModel.cumulativeTime > 0) {
      memos = MemoService.getMemosByDate(
        zeroBaseModel.lastDate,
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: memos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Memo> memo = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: makeList(memo),
                ),
              ],
            );
          }
          return const Text(
            "",
          );
        },
      ),
    );
  }
}

ListView makeList(List<Memo> memos) {
  return ListView.separated(
    // 한번에 모든 데이터를 Builder하는 것이 아니라 itemBuilder함수가 필요한 index에 대해서만 build한다.
    itemCount: memos.length,

    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
    itemBuilder: (context, index) {
      Memo memo = memos[index];
      return AlarmLogCard(
        memo: memo,
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 20,
    ),
  );
}
