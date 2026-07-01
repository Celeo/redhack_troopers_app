import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weapon.dart';
import '../providers/character_provider.dart';
import '../screens/character_sheet_screen.dart';

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
      ],
    );
  }
}

