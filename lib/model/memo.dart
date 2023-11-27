class Memo {
  int? id; // Primary key
  String content;
  String satisfaction;
  DateTime createdAt;
  DateTime stoppedAt;

  Memo({
    this.id,
    required this.content,
    required this.satisfaction,
    required this.createdAt,
    required this.stoppedAt,
  });

  // 데이터베이스에서 읽어온 Map을 Memo 객체로 변환
  factory Memo.fromMap(Map<String, dynamic> json) => Memo(
        id: json['id'],
        content: json['content'],
        satisfaction: json['satisfaction'],
        createdAt: DateTime.parse(json['createdAt']),
        stoppedAt: DateTime.parse(json['stoppedAt']),
      );

  // Memo 객체를 Map으로 변환
  Map<String, dynamic> toMap() => {
        'id': id,
        'content': content,
        'satisfaction': satisfaction,
        'createdAt': createdAt.toIso8601String(),
        'stoppedAt': stoppedAt.toIso8601String(),
      };
}
