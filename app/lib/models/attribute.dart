class Attribute {
  final int score;
  final int current;
  final bool isSavingThrow;

  const Attribute({this.score = 10, this.current = 10, this.isSavingThrow = false});

  int get mod => (score - 10) ~/ 2;

  Attribute copyWith({int? score, int? current, bool? isSavingThrow}) => Attribute(
        score: score ?? this.score,
        current: current ?? this.current,
        isSavingThrow: isSavingThrow ?? this.isSavingThrow,
      );

  Map<String, dynamic> toJson() => {
        'score': score,
        'current': current,
        'isSavingThrow': isSavingThrow,
      };

  factory Attribute.fromJson(Map<String, dynamic> j) => Attribute(
        score: (j['score'] as num?)?.toInt() ?? 10,
        current: (j['current'] as num?)?.toInt() ?? 10,
        isSavingThrow: j['isSavingThrow'] as bool? ?? false,
      );
}
