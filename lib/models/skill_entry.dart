class SkillEntry {
  final String name;
  final String subtitle;
  final String attribute;   // 'BODY', 'AGIL', 'MIND', 'PRES'
  final String? attribute2; // set for dual-attribute skills
  final int ranks;

  const SkillEntry({
    required this.name,
    required this.subtitle,
    required this.attribute,
    this.attribute2,
    this.ranks = 0,
  });

  SkillEntry copyWith({int? ranks}) => SkillEntry(
        name: name,
        subtitle: subtitle,
        attribute: attribute,
        attribute2: attribute2,
        ranks: ranks ?? this.ranks,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'subtitle': subtitle,
        'attribute': attribute,
        if (attribute2 != null) 'attribute2': attribute2,
        'ranks': ranks,
      };

  factory SkillEntry.fromJson(Map<String, dynamic> j) => SkillEntry(
        name: j['name'] as String,
        subtitle: j['subtitle'] as String? ?? '',
        attribute: j['attribute'] as String,
        attribute2: j['attribute2'] as String?,
        ranks: (j['ranks'] as num?)?.toInt() ?? 0,
      );

  static List<SkillEntry> defaults() => const [
        SkillEntry(name: 'Computers',   subtitle: 'Hacking & IT',             attribute: 'MIND'),
        SkillEntry(name: 'Engineering', subtitle: 'Build & Disable',           attribute: 'MIND'),
        SkillEntry(name: 'Ferocity',    subtitle: 'Combat & Athletics',        attribute: 'BODY', attribute2: 'AGIL'),
        SkillEntry(name: 'Medicine',    subtitle: 'Heal & Biology',            attribute: 'MIND'),
        SkillEntry(name: 'Munitions',   subtitle: 'Combat Systems & Bombs',    attribute: 'PRES'),
        SkillEntry(name: 'Persuade',    subtitle: 'Convince & Communicate',    attribute: 'PRES'),
        SkillEntry(name: 'Pilot',       subtitle: 'Drive & Drone',             attribute: 'AGIL', attribute2: 'PRES'),
        SkillEntry(name: 'Stealth',     subtitle: 'Sneaking & Infiltration',   attribute: 'AGIL'),
      ];
}
