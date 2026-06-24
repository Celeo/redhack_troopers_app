class Vehicle {
  final String type;
  final int hp;
  final int dr;
  final int speed;
  final String impactDie;
  final int ac;
  final int seats;
  final String cover;
  final String notes;

  const Vehicle({
    this.type = '',
    this.hp = 0,
    this.dr = 0,
    this.speed = 0,
    this.impactDie = '',
    this.ac = 0,
    this.seats = 0,
    this.cover = '',
    this.notes = '',
  });

  Vehicle copyWith({
    String? type,
    int? hp,
    int? dr,
    int? speed,
    String? impactDie,
    int? ac,
    int? seats,
    String? cover,
    String? notes,
  }) =>
      Vehicle(
        type: type ?? this.type,
        hp: hp ?? this.hp,
        dr: dr ?? this.dr,
        speed: speed ?? this.speed,
        impactDie: impactDie ?? this.impactDie,
        ac: ac ?? this.ac,
        seats: seats ?? this.seats,
        cover: cover ?? this.cover,
        notes: notes ?? this.notes,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'hp': hp,
        'dr': dr,
        'speed': speed,
        'impactDie': impactDie,
        'ac': ac,
        'seats': seats,
        'cover': cover,
        'notes': notes,
      };

  factory Vehicle.fromJson(Map<String, dynamic> j) => Vehicle(
        type: j['type'] as String? ?? '',
        hp: (j['hp'] as num?)?.toInt() ?? 0,
        dr: (j['dr'] as num?)?.toInt() ?? 0,
        speed: (j['speed'] as num?)?.toInt() ?? 0,
        impactDie: j['impactDie'] as String? ?? '',
        ac: (j['ac'] as num?)?.toInt() ?? 0,
        seats: (j['seats'] as num?)?.toInt() ?? 0,
        cover: j['cover'] as String? ?? '',
        notes: j['notes'] as String? ?? '',
      );
}
