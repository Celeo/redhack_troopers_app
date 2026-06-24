class Weapon {
  final String name;
  final int attBonus;
  final String damage;
  final int currentAmmo;
  final int maxAmmo;
  final String range;

  const Weapon({
    this.name = '',
    this.attBonus = 0,
    this.damage = '',
    this.currentAmmo = 0,
    this.maxAmmo = 0,
    this.range = '',
  });

  Weapon copyWith({
    String? name,
    int? attBonus,
    String? damage,
    int? currentAmmo,
    int? maxAmmo,
    String? range,
  }) =>
      Weapon(
        name: name ?? this.name,
        attBonus: attBonus ?? this.attBonus,
        damage: damage ?? this.damage,
        currentAmmo: currentAmmo ?? this.currentAmmo,
        maxAmmo: maxAmmo ?? this.maxAmmo,
        range: range ?? this.range,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'attBonus': attBonus,
        'damage': damage,
        'currentAmmo': currentAmmo,
        'maxAmmo': maxAmmo,
        'range': range,
      };

  factory Weapon.fromJson(Map<String, dynamic> j) => Weapon(
        name: j['name'] as String? ?? '',
        attBonus: (j['attBonus'] as num?)?.toInt() ?? 0,
        damage: j['damage'] as String? ?? '',
        currentAmmo: (j['currentAmmo'] as num?)?.toInt() ?? 0,
        maxAmmo: (j['maxAmmo'] as num?)?.toInt() ?? 0,
        range: j['range'] as String? ?? '',
      );
}
