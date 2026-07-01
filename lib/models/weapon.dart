class Weapon {
  final String name;
  final int attBonus;
  final String damage;
  final String range;

  const Weapon({
    this.name = '',
    this.attBonus = 0,
    this.damage = '',
    this.range = '',
  });

  Weapon copyWith({
    String? name,
    int? attBonus,
    String? damage,
    String? range,
  }) =>
      Weapon(
        name: name ?? this.name,
        attBonus: attBonus ?? this.attBonus,
        damage: damage ?? this.damage,
        range: range ?? this.range,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'attBonus': attBonus,
        'damage': damage,
        'range': range,
      };

  factory Weapon.fromJson(Map<String, dynamic> j) => Weapon(
        name: j['name'] as String? ?? '',
        attBonus: (j['attBonus'] as num?)?.toInt() ?? 0,
        damage: j['damage'] as String? ?? '',
        range: j['range'] as String? ?? '',
      );
}
