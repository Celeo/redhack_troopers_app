class Attribute {
  final int score;
  final int current;
  final bool isSavingThrow;

  const Attribute({this.score = 0, this.current = 0, this.isSavingThrow = false});

  int get mod => score;

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
        score: (j['score'] as num?)?.toInt() ?? 0,
        current: (j['current'] as num?)?.toInt() ?? 0,
        isSavingThrow: j['isSavingThrow'] as bool? ?? false,
      );
}
