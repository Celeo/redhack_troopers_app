import 'attribute.dart';
import 'weapon.dart';
import 'skill_entry.dart';
import 'gear_item.dart';
import 'contact.dart';
import 'vehicle.dart';

class Character {
  final String name;
  final String playerName;
  final String initHitDie;
  final int xp;
  final int level;
  final int speed;
  final int credits;
  final String lifestyle;

  final Attribute body;
  final Attribute agility;
  final Attribute mind;
  final Attribute presence;
  final Attribute luck;

  final int currentHp;
  final int maxHp;

  final String armorName;
  final int totalAc;
  final bool hasShield;
  final int dr;
  final int drShield;

  final Weapon weapon1;
  final Weapon weapon2;
  final Weapon weapon3;

  final int psionicsMaxUd;
  final int psionicsCurrentUd;
  final String psionicsFoci;

  final Vehicle vehicle;

  final List<SkillEntry> skills;
  final int unusedSkillPoints;
  final List<String> training;

  final int currentLoad;
  final int maxLoad;
  final List<GearItem> gear;
  final List<Contact> contacts;
  final String notes;

  Character({
    this.name = '',
    this.playerName = '',
    this.initHitDie = '',
    this.xp = 0,
    this.level = 1,
    this.speed = 30,
    this.credits = 0,
    this.lifestyle = '',
    Attribute? body,
    Attribute? agility,
    Attribute? mind,
    Attribute? presence,
    Attribute? luck,
    this.currentHp = 0,
    this.maxHp = 0,
    this.armorName = '',
    this.totalAc = 10,
    this.hasShield = false,
    this.dr = 0,
    this.drShield = 0,
    Weapon? weapon1,
    Weapon? weapon2,
    Weapon? weapon3,
    this.psionicsMaxUd = 0,
    this.psionicsCurrentUd = 0,
    this.psionicsFoci = '',
    Vehicle? vehicle,
    List<SkillEntry>? skills,
    this.unusedSkillPoints = 0,
    List<String>? training,
    this.currentLoad = 0,
    this.maxLoad = 0,
    List<GearItem>? gear,
    List<Contact>? contacts,
    this.notes = '',
  })  : body = body ?? const Attribute(),
        agility = agility ?? const Attribute(),
        mind = mind ?? const Attribute(),
        presence = presence ?? const Attribute(),
        luck = luck ?? const Attribute(),
        weapon1 = weapon1 ?? const Weapon(),
        weapon2 = weapon2 ?? const Weapon(),
        weapon3 = weapon3 ?? const Weapon(),
        vehicle = vehicle ?? const Vehicle(),
        skills = skills ?? SkillEntry.defaults(),
        training = training ?? List.filled(7, ''),
        gear = gear ?? const [],
        contacts = contacts ?? List.generate(7, (_) => const Contact());

  int attrMod(String attr) {
    switch (attr) {
      case 'BODY':
        return body.mod;
      case 'AGIL':
        return agility.mod;
      case 'MIND':
        return mind.mod;
      case 'PRES':
        return presence.mod;
      default:
        return luck.mod;
    }
  }

  Character copyWith({
    String? name,
    String? playerName,
    String? initHitDie,
    int? xp,
    int? level,
    int? speed,
    int? credits,
    String? lifestyle,
    Attribute? body,
    Attribute? agility,
    Attribute? mind,
    Attribute? presence,
    Attribute? luck,
    int? currentHp,
    int? maxHp,
    String? armorName,
    int? totalAc,
    bool? hasShield,
    int? dr,
    int? drShield,
    Weapon? weapon1,
    Weapon? weapon2,
    Weapon? weapon3,
    int? psionicsMaxUd,
    int? psionicsCurrentUd,
    String? psionicsFoci,
    Vehicle? vehicle,
    List<SkillEntry>? skills,
    int? unusedSkillPoints,
    List<String>? training,
    int? currentLoad,
    int? maxLoad,
    List<GearItem>? gear,
    List<Contact>? contacts,
    String? notes,
  }) =>
      Character(
        name: name ?? this.name,
        playerName: playerName ?? this.playerName,
        initHitDie: initHitDie ?? this.initHitDie,
        xp: xp ?? this.xp,
        level: level ?? this.level,
        speed: speed ?? this.speed,
        credits: credits ?? this.credits,
        lifestyle: lifestyle ?? this.lifestyle,
        body: body ?? this.body,
        agility: agility ?? this.agility,
        mind: mind ?? this.mind,
        presence: presence ?? this.presence,
        luck: luck ?? this.luck,
        currentHp: currentHp ?? this.currentHp,
        maxHp: maxHp ?? this.maxHp,
        armorName: armorName ?? this.armorName,
        totalAc: totalAc ?? this.totalAc,
        hasShield: hasShield ?? this.hasShield,
        dr: dr ?? this.dr,
        drShield: drShield ?? this.drShield,
        weapon1: weapon1 ?? this.weapon1,
        weapon2: weapon2 ?? this.weapon2,
        weapon3: weapon3 ?? this.weapon3,
        psionicsMaxUd: psionicsMaxUd ?? this.psionicsMaxUd,
        psionicsCurrentUd: psionicsCurrentUd ?? this.psionicsCurrentUd,
        psionicsFoci: psionicsFoci ?? this.psionicsFoci,
        vehicle: vehicle ?? this.vehicle,
        skills: skills ?? this.skills,
        unusedSkillPoints: unusedSkillPoints ?? this.unusedSkillPoints,
        training: training ?? this.training,
        currentLoad: currentLoad ?? this.currentLoad,
        maxLoad: maxLoad ?? this.maxLoad,
        gear: gear ?? this.gear,
        contacts: contacts ?? this.contacts,
        notes: notes ?? this.notes,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'playerName': playerName,
        'initHitDie': initHitDie,
        'xp': xp,
        'level': level,
        'speed': speed,
        'credits': credits,
        'lifestyle': lifestyle,
        'body': body.toJson(),
        'agility': agility.toJson(),
        'mind': mind.toJson(),
        'presence': presence.toJson(),
        'luck': luck.toJson(),
        'currentHp': currentHp,
        'maxHp': maxHp,
        'armorName': armorName,
        'totalAc': totalAc,
        'hasShield': hasShield,
        'dr': dr,
        'drShield': drShield,
        'weapon1': weapon1.toJson(),
        'weapon2': weapon2.toJson(),
        'weapon3': weapon3.toJson(),
        'psionicsMaxUd': psionicsMaxUd,
        'psionicsCurrentUd': psionicsCurrentUd,
        'psionicsFoci': psionicsFoci,
        'vehicle': vehicle.toJson(),
        'skills': skills.map((s) => s.toJson()).toList(),
        'unusedSkillPoints': unusedSkillPoints,
        'training': training,
        'currentLoad': currentLoad,
        'maxLoad': maxLoad,
        'gear': gear.map((g) => g.toJson()).toList(),
        'contacts': contacts.map((c) => c.toJson()).toList(),
        'notes': notes,
      };

  factory Character.fromJson(Map<String, dynamic> j) => Character(
        name: j['name'] as String? ?? '',
        playerName: j['playerName'] as String? ?? '',
        initHitDie: j['initHitDie'] as String? ?? '',
        xp: (j['xp'] as num?)?.toInt() ?? 0,
        level: (j['level'] as num?)?.toInt() ?? 1,
        speed: (j['speed'] as num?)?.toInt() ?? 30,
        credits: (j['credits'] as num?)?.toInt() ?? 0,
        lifestyle: j['lifestyle'] as String? ?? '',
        body: j['body'] != null
            ? Attribute.fromJson(j['body'] as Map<String, dynamic>)
            : null,
        agility: j['agility'] != null
            ? Attribute.fromJson(j['agility'] as Map<String, dynamic>)
            : null,
        mind: j['mind'] != null
            ? Attribute.fromJson(j['mind'] as Map<String, dynamic>)
            : null,
        presence: j['presence'] != null
            ? Attribute.fromJson(j['presence'] as Map<String, dynamic>)
            : null,
        luck: j['luck'] != null
            ? Attribute.fromJson(j['luck'] as Map<String, dynamic>)
            : null,
        currentHp: (j['currentHp'] as num?)?.toInt() ?? 0,
        maxHp: (j['maxHp'] as num?)?.toInt() ?? 0,
        armorName: j['armorName'] as String? ?? '',
        totalAc: (j['totalAc'] as num?)?.toInt() ?? 10,
        hasShield: j['hasShield'] as bool? ?? false,
        dr: (j['dr'] as num?)?.toInt() ?? 0,
        drShield: (j['drShield'] as num?)?.toInt() ?? 0,
        weapon1: j['weapon1'] != null
            ? Weapon.fromJson(j['weapon1'] as Map<String, dynamic>)
            : null,
        weapon2: j['weapon2'] != null
            ? Weapon.fromJson(j['weapon2'] as Map<String, dynamic>)
            : null,
        weapon3: j['weapon3'] != null
            ? Weapon.fromJson(j['weapon3'] as Map<String, dynamic>)
            : null,
        psionicsMaxUd: (j['psionicsMaxUd'] as num?)?.toInt() ?? 0,
        psionicsCurrentUd: (j['psionicsCurrentUd'] as num?)?.toInt() ?? 0,
        psionicsFoci: j['psionicsFoci'] as String? ?? '',
        vehicle: j['vehicle'] != null
            ? Vehicle.fromJson(j['vehicle'] as Map<String, dynamic>)
            : null,
        skills: j['skills'] != null
            ? (j['skills'] as List)
                .map((s) => SkillEntry.fromJson(s as Map<String, dynamic>))
                .toList()
            : null,
        unusedSkillPoints: (j['unusedSkillPoints'] as num?)?.toInt() ?? 0,
        training: j['training'] != null
            ? List<String>.from(j['training'] as List)
            : null,
        currentLoad: (j['currentLoad'] as num?)?.toInt() ?? 0,
        maxLoad: (j['maxLoad'] as num?)?.toInt() ?? 0,
        gear: j['gear'] != null
            ? (j['gear'] as List)
                .map((g) => GearItem.fromJson(g as Map<String, dynamic>))
                .toList()
            : null,
        contacts: j['contacts'] != null
            ? (j['contacts'] as List)
                .map((c) => Contact.fromJson(c as Map<String, dynamic>))
                .toList()
            : null,
        notes: j['notes'] as String? ?? '',
      );
}
