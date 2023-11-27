import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../configuration/db/db_provider.dart';
import '../model/memo.dart';

class MemoService {
  static Future<void> insertMemo(Memo memo) async {
    final db = await DatabaseProvider.instance.database;
    await db.insert(
      'memos',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Memo>> getMemos() async {
    final db = await DatabaseProvider.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('memos');
    return List.generate(maps.length, (i) {
      return Memo.fromMap(maps[i]);
    });
  }

  static Future<List<Memo>> getMemosByDate(DateTime date) async {
    final db = await DatabaseProvider.instance.database;
    // 날짜를 'YYYY-MM-DD' 형식으로 변환
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final List<Map<String, dynamic>> maps = await db.query(
      'memos',
      where: "strftime('%Y-%m-%d', createdAt) = ?",
      whereArgs: [formattedDate],
    );

    return List.generate(maps.length, (i) {
      return Memo.fromMap(maps[i]);
    });
  }
}
