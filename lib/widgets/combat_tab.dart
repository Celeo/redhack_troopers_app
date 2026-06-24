import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weapon.dart';
import '../models/vehicle.dart';
import '../providers/character_provider.dart';
import '../screens/character_sheet_screen.dart';
import '../theme.dart';

class CombatTab extends ConsumerWidget {
  const CombatTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ── Armor ─────────────────────────────────────────────
        sectionHeader('ARMOR'),
        _ArmorSection(notifier: notifier, c: c),

        // ── Weapons ───────────────────────────────────────────
        sectionHeader('WEAPON 1'),
        _WeaponCard(
          weapon: c.weapon1,
          onChanged: (w) => notifier.update((c) => c.copyWith(weapon1: w)),
        ),
        sectionHeader('WEAPON 2'),
        _WeaponCard(
          weapon: c.weapon2,
          onChanged: (w) => notifier.update((c) => c.copyWith(weapon2: w)),
        ),
        sectionHeader('WEAPON 3'),
        _WeaponCard(
          weapon: c.weapon3,
          onChanged: (w) => notifier.update((c) => c.copyWith(weapon3: w)),
        ),

        // ── Psionics ──────────────────────────────────────────
        sectionHeader('PSIONICS'),
        _PsionicsSection(notifier: notifier, c: c),

        // ── Vehicle ───────────────────────────────────────────
        sectionHeader('VEHICLE'),
        _VehicleSection(notifier: notifier, c: c),
      ],
    );
  }
}

// ── Armor ────────────────────────────────────────────────────

class _ArmorSection extends ConsumerStatefulWidget {
  final CharacterNotifier notifier;
  final dynamic c;

  const _ArmorSection({required this.notifier, required this.c});

  @override
  ConsumerState<_ArmorSection> createState() => _ArmorSectionState();
}

class _ArmorSectionState extends ConsumerState<_ArmorSection> {
  late TextEditingController _armorName;
  late TextEditingController _totalAc;
  late TextEditingController _dr;

  @override
  void initState() {
    super.initState();
    final c = ref.read(characterProvider);
    _armorName = TextEditingController(text: c.armorName);
    _totalAc = TextEditingController(text: '${c.totalAc}');
    _dr = TextEditingController(text: '${c.dr}');
  }

  @override
  void dispose() {
    for (final c in [_armorName, _totalAc, _dr]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            flex: 2,
            child: labeledField(
              label: 'ARMOR TYPE',
              controller: _armorName,
              onChanged: (v) =>
                  widget.notifier.update((c) => c.copyWith(armorName: v)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'TOTAL AC',
              controller: _totalAc,
              keyboardType: TextInputType.number,
              onChanged: (v) => widget.notifier
                  .update((c) => c.copyWith(totalAc: int.tryParse(v) ?? c.totalAc)),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: labeledField(
              label: 'DR',
              controller: _dr,
              keyboardType: TextInputType.number,
              onChanged: (v) => widget.notifier
                  .update((c) => c.copyWith(dr: int.tryParse(v) ?? c.dr)),
            ),
          ),
        ]),
      ],
    );
  }
}

// ── Weapon ───────────────────────────────────────────────────

class _WeaponCard extends StatefulWidget {
  final Weapon weapon;
  final ValueChanged<Weapon> onChanged;

  const _WeaponCard({required this.weapon, required this.onChanged});

  @override
  State<_WeaponCard> createState() => _WeaponCardState();
}

class _WeaponCardState extends State<_WeaponCard> {
  late TextEditingController _name;
  late TextEditingController _att;
  late TextEditingController _dmg;
  late TextEditingController _range;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.weapon.name);
    _att = TextEditingController(
        text: widget.weapon.attBonus == 0 ? '' : '${widget.weapon.attBonus}');
    _dmg = TextEditingController(text: widget.weapon.damage);
    _range = TextEditingController(text: widget.weapon.range);
  }

  @override
  void dispose() {
    for (final c in [_name, _att, _dmg, _range]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.weapon;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labeledField(
          label: 'WEAPON NAME',
          controller: _name,
          onChanged: (v) => widget.onChanged(w.copyWith(name: v)),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: labeledField(
              label: 'ATT BONUS',
              controller: _att,
              keyboardType: TextInputType.numberWithOptions(signed: true),
              onChanged: (v) =>
                  widget.onChanged(w.copyWith(attBonus: int.tryParse(v) ?? w.attBonus)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'DAMAGE',
              controller: _dmg,
              onChanged: (v) => widget.onChanged(w.copyWith(damage: v)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'RANGE',
              controller: _range,
              onChanged: (v) => widget.onChanged(w.copyWith(range: v)),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('AMMO', style: TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, size: 18),
              onPressed: () => widget.onChanged(w.copyWith(currentAmmo: w.currentAmmo - 1)),
              color: kGold,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 4),
            Text('${w.currentAmmo}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.add_circle_outline, size: 18),
              onPressed: () => widget.onChanged(w.copyWith(currentAmmo: w.currentAmmo + 1)),
              color: kGold,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const Text(' / ', style: TextStyle(color: Colors.white38)),
            SizedBox(
              width: 48,
              child: TextField(
                controller: TextEditingController(
                    text: w.maxAmmo == 0 ? '' : '${w.maxAmmo}'),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(isDense: true, hintText: 'max'),
                onChanged: (v) =>
                    widget.onChanged(w.copyWith(maxAmmo: int.tryParse(v) ?? w.maxAmmo)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ── Psionics ─────────────────────────────────────────────────

class _PsionicsSection extends ConsumerStatefulWidget {
  final CharacterNotifier notifier;
  final dynamic c;

  const _PsionicsSection({required this.notifier, required this.c});

  @override
  ConsumerState<_PsionicsSection> createState() => _PsionicsSectionState();
}

class _PsionicsSectionState extends ConsumerState<_PsionicsSection> {
  late TextEditingController _foci;

  @override
  void initState() {
    super.initState();
    _foci = TextEditingController(text: ref.read(characterProvider).psionicsFoci);
  }

  @override
  void dispose() {
    _foci.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = ref.watch(characterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MAX UD',
                    style: TextStyle(color: Colors.white38, fontSize: 10)),
                udDropdown(c.psionicsMaxUd,
                    (v) => widget.notifier.update((c) => c.copyWith(psionicsMaxUd: v ?? 0))),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('CURRENT UD',
                    style: TextStyle(color: Colors.white38, fontSize: 10)),
                udDropdown(c.psionicsCurrentUd,
                    (v) => widget.notifier.update((c) => c.copyWith(psionicsCurrentUd: v ?? 0))),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 8),
        labeledField(
          label: 'FOCI',
          controller: _foci,
          onChanged: (v) => widget.notifier.update((c) => c.copyWith(psionicsFoci: v)),
          maxLines: 2,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ── Vehicle ──────────────────────────────────────────────────

class _VehicleSection extends ConsumerStatefulWidget {
  final CharacterNotifier notifier;
  final dynamic c;

  const _VehicleSection({required this.notifier, required this.c});

  @override
  ConsumerState<_VehicleSection> createState() => _VehicleSectionState();
}

class _VehicleSectionState extends ConsumerState<_VehicleSection> {
  late TextEditingController _type;
  late TextEditingController _hp;
  late TextEditingController _dr;
  late TextEditingController _speed;
  late TextEditingController _impactDie;
  late TextEditingController _ac;
  late TextEditingController _seats;
  late TextEditingController _cover;
  late TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    final v = ref.read(characterProvider).vehicle;
    _type = TextEditingController(text: v.type);
    _hp = TextEditingController(text: v.hp == 0 ? '' : '${v.hp}');
    _dr = TextEditingController(text: v.dr == 0 ? '' : '${v.dr}');
    _speed = TextEditingController(text: v.speed == 0 ? '' : '${v.speed}');
    _impactDie = TextEditingController(text: v.impactDie);
    _ac = TextEditingController(text: v.ac == 0 ? '' : '${v.ac}');
    _seats = TextEditingController(text: v.seats == 0 ? '' : '${v.seats}');
    _cover = TextEditingController(text: v.cover);
    _notes = TextEditingController(text: v.notes);
  }

  @override
  void dispose() {
    for (final c in [_type, _hp, _dr, _speed, _impactDie, _ac, _seats, _cover, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  void _update(Vehicle Function(Vehicle) fn) {
    widget.notifier.update((c) => c.copyWith(vehicle: fn(c.vehicle)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            flex: 2,
            child: labeledField(
              label: 'VEHICLE TYPE',
              controller: _type,
              onChanged: (v) => _update((vh) => vh.copyWith(type: v)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'HP',
              controller: _hp,
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _update((vh) => vh.copyWith(hp: int.tryParse(v) ?? vh.hp)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'DR',
              controller: _dr,
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _update((vh) => vh.copyWith(dr: int.tryParse(v) ?? vh.dr)),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: labeledField(
              label: 'SPEED',
              controller: _speed,
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _update((vh) => vh.copyWith(speed: int.tryParse(v) ?? vh.speed)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'IMPACT DIE',
              controller: _impactDie,
              onChanged: (v) => _update((vh) => vh.copyWith(impactDie: v)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'AC',
              controller: _ac,
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _update((vh) => vh.copyWith(ac: int.tryParse(v) ?? vh.ac)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'SEATS',
              controller: _seats,
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _update((vh) => vh.copyWith(seats: int.tryParse(v) ?? vh.seats)),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: labeledField(
              label: 'COVER',
              controller: _cover,
              onChanged: (v) => _update((vh) => vh.copyWith(cover: v)),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        labeledField(
          label: 'NOTES',
          controller: _notes,
          onChanged: (v) => _update((vh) => vh.copyWith(notes: v)),
          maxLines: 2,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
