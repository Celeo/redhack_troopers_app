class GearItem {
  final String name;
  final int load;

  const GearItem({this.name = '', this.load = 0});

  GearItem copyWith({String? name, int? load}) =>
      GearItem(name: name ?? this.name, load: load ?? this.load);

  Map<String, dynamic> toJson() => {'name': name, 'load': load};

  factory GearItem.fromJson(Map<String, dynamic> j) => GearItem(
        name: j['name'] as String? ?? '',
        load: (j['load'] as num?)?.toInt() ?? 0,
      );
}
