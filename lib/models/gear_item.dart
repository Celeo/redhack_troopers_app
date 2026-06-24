class GearItem {
  final String name;
  final int ud; // usage die size: 0=none, 4, 6, 8, 10, 12
  final int load;

  const GearItem({this.name = '', this.ud = 0, this.load = 0});

  GearItem copyWith({String? name, int? ud, int? load}) =>
      GearItem(name: name ?? this.name, ud: ud ?? this.ud, load: load ?? this.load);

  Map<String, dynamic> toJson() => {'name': name, 'ud': ud, 'load': load};

  factory GearItem.fromJson(Map<String, dynamic> j) => GearItem(
        name: j['name'] as String? ?? '',
        ud: (j['ud'] as num?)?.toInt() ?? 0,
        load: (j['load'] as num?)?.toInt() ?? 0,
      );
}
