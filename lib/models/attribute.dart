class Attribute {
  final int score;
  final bool hasMastery;

  const Attribute({this.score = 0, this.hasMastery = false});

  int get mod => score;

  Attribute copyWith({int? score, bool? hasMastery}) => Attribute(
        score: score ?? this.score,
        hasMastery: hasMastery ?? this.hasMastery,
      );

  Map<String, dynamic> toJson() => {
        'score': score,
        'hasMastery': hasMastery,
      };

  factory Attribute.fromJson(Map<String, dynamic> j) => Attribute(
        score: (j['score'] as num?)?.toInt() ?? 0,
        // migrate old 'isSavingThrow' key
        hasMastery: j['hasMastery'] as bool? ?? j['isSavingThrow'] as bool? ?? false,
      );
}
