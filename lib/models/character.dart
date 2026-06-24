import 'attribute.dart';
import 'weapon.dart';
import 'skill_entry.dart';
import 'gear_item.dart';
import 'contact.dart';

class Character {
  final String name;
  final String playerName;
  final String initHitDie;
  final int xp;
  final int level;
  final int speed;
  final String masteryEdges;

  final Attribute body;
  final Attribute agility;
  final Attribute mind;
  final Attribute presence;
  final String wealth;

  final int currentHp;
  final int maxHp;
  final bool trauma1;
  final bool trauma2;

  final String armorName;
  final int totalAc;
  final int dr;

  final Weapon weapon1;
  final Weapon weapon2;
  final Weapon weapon3;

  final List<SkillEntry> skills;
  final List<String> training;

  final int funds;
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
    this.masteryEdges = '',
    Attribute? body,
    Attribute? agility,
    Attribute? mind,
    Attribute? presence,
    this.wealth = '',
    this.currentHp = 0,
    this.maxHp = 0,
    this.trauma1 = false,
    this.trauma2 = false,
    this.armorName = '',
    this.totalAc = 10,
    this.dr = 0,
    Weapon? weapon1,
    Weapon? weapon2,
    Weapon? weapon3,
    List<SkillEntry>? skills,
    List<String>? training,
    this.funds = 0,
    this.maxLoad = 0,
    List<GearItem>? gear,
    List<Contact>? contacts,
    this.notes = '',
  })  : body = body ?? const Attribute(),
        agility = agility ?? const Attribute(),
        mind = mind ?? const Attribute(),
        presence = presence ?? const Attribute(),
        weapon1 = weapon1 ?? const Weapon(),
        weapon2 = weapon2 ?? const Weapon(),
        weapon3 = weapon3 ?? const Weapon(),
        skills = skills ?? SkillEntry.defaults(),
        training = training ?? List.filled(7, ''),
        gear = gear ?? const [],
        contacts = contacts ?? List.generate(7, (_) => const Contact());

  int get currentLoad => gear.fold(0, (sum, g) => sum + g.load);

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
        return 0;
    }
  }

  Character copyWith({
    String? name,
    String? playerName,
    String? initHitDie,
    int? xp,
    int? level,
    int? speed,
    String? masteryEdges,
    Attribute? body,
    Attribute? agility,
    Attribute? mind,
    Attribute? presence,
    String? wealth,
    int? currentHp,
    int? maxHp,
    bool? trauma1,
    bool? trauma2,
    String? armorName,
    int? totalAc,
    int? dr,
    Weapon? weapon1,
    Weapon? weapon2,
    Weapon? weapon3,
    List<SkillEntry>? skills,
    List<String>? training,
    int? funds,
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
        masteryEdges: masteryEdges ?? this.masteryEdges,
        body: body ?? this.body,
        agility: agility ?? this.agility,
        mind: mind ?? this.mind,
        presence: presence ?? this.presence,
        wealth: wealth ?? this.wealth,
        currentHp: currentHp ?? this.currentHp,
        maxHp: maxHp ?? this.maxHp,
        trauma1: trauma1 ?? this.trauma1,
        trauma2: trauma2 ?? this.trauma2,
        armorName: armorName ?? this.armorName,
        totalAc: totalAc ?? this.totalAc,
        dr: dr ?? this.dr,
        weapon1: weapon1 ?? this.weapon1,
        weapon2: weapon2 ?? this.weapon2,
        weapon3: weapon3 ?? this.weapon3,
        skills: skills ?? this.skills,
        training: training ?? this.training,
        funds: funds ?? this.funds,
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
        'masteryEdges': masteryEdges,
        'body': body.toJson(),
        'agility': agility.toJson(),
        'mind': mind.toJson(),
        'presence': presence.toJson(),
        'wealth': wealth,
        'currentHp': currentHp,
        'maxHp': maxHp,
        'trauma1': trauma1,
        'trauma2': trauma2,
        'armorName': armorName,
        'totalAc': totalAc,
        'dr': dr,
        'weapon1': weapon1.toJson(),
        'weapon2': weapon2.toJson(),
        'weapon3': weapon3.toJson(),
        'skills': skills.map((s) => s.toJson()).toList(),
        'training': training,
        'funds': funds,
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
        masteryEdges: j['masteryEdges'] as String? ?? '',
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
        wealth: j['wealth'] as String? ?? '',
        currentHp: (j['currentHp'] as num?)?.toInt() ?? 0,
        maxHp: (j['maxHp'] as num?)?.toInt() ?? 0,
        trauma1: j['trauma1'] as bool? ?? false,
        trauma2: j['trauma2'] as bool? ?? false,
        armorName: j['armorName'] as String? ?? '',
        totalAc: (j['totalAc'] as num?)?.toInt() ?? 10,
        dr: (j['dr'] as num?)?.toInt() ?? 0,
        weapon1: j['weapon1'] != null
            ? Weapon.fromJson(j['weapon1'] as Map<String, dynamic>)
            : null,
        weapon2: j['weapon2'] != null
            ? Weapon.fromJson(j['weapon2'] as Map<String, dynamic>)
            : null,
        weapon3: j['weapon3'] != null
            ? Weapon.fromJson(j['weapon3'] as Map<String, dynamic>)
            : null,
        skills: j['skills'] != null
            ? (j['skills'] as List)
                .map((s) => SkillEntry.fromJson(s as Map<String, dynamic>))
                .toList()
            : null,
        training: j['training'] != null
            ? List<String>.from(j['training'] as List)
            : null,
        // migrate old 'credits' key
        funds: (j['funds'] as num?)?.toInt() ?? (j['credits'] as num?)?.toInt() ?? 0,
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
