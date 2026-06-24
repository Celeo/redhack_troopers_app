class SkillEntry {
  final String name;
  final String attribute; // 'BODY', 'AGIL', 'MIND', 'PRES'
  final int ranks;

  const SkillEntry({required this.name, required this.attribute, this.ranks = 0});

  SkillEntry copyWith({int? ranks}) =>
      SkillEntry(name: name, attribute: attribute, ranks: ranks ?? this.ranks);

  Map<String, dynamic> toJson() => {'name': name, 'attribute': attribute, 'ranks': ranks};

  factory SkillEntry.fromJson(Map<String, dynamic> j) => SkillEntry(
        name: j['name'] as String,
        attribute: j['attribute'] as String,
        ranks: (j['ranks'] as num?)?.toInt() ?? 0,
      );

  static List<SkillEntry> defaults() => const [
        SkillEntry(name: 'Armor', attribute: 'BODY'),
        SkillEntry(name: 'Athletics', attribute: 'BODY'),
        SkillEntry(name: 'Biology', attribute: 'MIND'),
        SkillEntry(name: 'Computers', attribute: 'MIND'),
        SkillEntry(name: 'Engineering', attribute: 'MIND'),
        SkillEntry(name: 'Firearms', attribute: 'AGIL'),
        SkillEntry(name: 'CQC', attribute: 'BODY'),
        SkillEntry(name: 'Pilot', attribute: 'AGIL'),
        SkillEntry(name: 'Perception', attribute: 'MIND'),
        SkillEntry(name: 'Persuade', attribute: 'PRES'),
        SkillEntry(name: 'Psionics', attribute: 'MIND'),
        SkillEntry(name: 'Research', attribute: 'MIND'),
        SkillEntry(name: 'Rumormonger', attribute: 'PRES'),
        SkillEntry(name: 'Stealth', attribute: 'AGIL'),
        SkillEntry(name: 'Survival', attribute: 'MIND'),
      ];
}
