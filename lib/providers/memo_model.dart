// MemoProvider로 전역적으로 관리하고 이에 따라 MEMO 클래스로 넘긴다.
import 'package:flutter/material.dart';

import '../model/memo.dart';
import '../service/memo_service.dart';

class MemoModel with ChangeNotifier {
  String _content = '지금 바로 시작하지 않은 이유';
  String _satisfaction = '';
  DateTime? _createdAt;
  DateTime? _stoppedAt;

  String get content => _content;
  String get satisfaction => _satisfaction;
  DateTime? get createdAt => _createdAt;
  DateTime? get stoppedAt => _stoppedAt;

  double? get durationSeconds =>
      _stoppedAt?.difference(_createdAt!).inSeconds.toDouble();

  set setContent(String value) {
    _content = value;
    notifyListeners();
  }

  set setSatisfaction(String value) {
    _satisfaction = value;
    notifyListeners();
  }

  set setCreatedAt(DateTime value) {
    _createdAt = value;
    notifyListeners();
  }

  set setStoppedAt(DateTime value) {
    _stoppedAt = value;
    notifyListeners();
  }

  void insertDb() async {
    try {
      Memo memo = Memo(
        content: _content,
        satisfaction: _satisfaction,
        createdAt: _createdAt!,
        stoppedAt: _stoppedAt!,
      );
      await MemoService.insertMemo(memo);
    } catch (e) {
      print(
        "${e.toString()} 이곳에서 나는 에러다",
      );
    }
  }
}
