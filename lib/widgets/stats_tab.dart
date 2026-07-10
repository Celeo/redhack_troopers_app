import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/attribute.dart';
import '../providers/character_provider.dart';
import '../screens/character_sheet_screen.dart';
import '../theme.dart';

class StatsTab extends ConsumerStatefulWidget {
  const StatsTab({super.key});

  @override
  ConsumerState<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends ConsumerState<StatsTab> {
  late final TextEditingController _name;
  late final TextEditingController _initHd;
  late final TextEditingController _xp;
  late final TextEditingController _level;
  late final TextEditingController _speed;
  late final TextEditingController _masteryEdges;

  @override
  void initState() {
    super.initState();
    final c = ref.read(characterProvider);
    _name = TextEditingController(text: c.name);
    _initHd = TextEditingController(text: c.initHitDie);
    _xp = TextEditingController(text: c.xp == 0 ? '' : '${c.xp}');
    _level = TextEditingController(text: '${c.level}');
    _speed = TextEditingController(text: '${c.speed}');
    _masteryEdges = TextEditingController(text: '${c.masteryEdges}');
  }

  @override
  void dispose() {
    for (final c in [_name, _initHd, _xp, _level, _speed, _masteryEdges]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ── Identity ──────────────────────────────────────────
        sectionHeader('IDENTITY'),
        labeledField(
          label: 'CHARACTER NAME',
          controller: _name,
          onChanged: (v) => notifier.update((c) => c.copyWith(name: v)),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: labeledField(
              label: 'LEVEL',
              controller: _level,
              keyboardType: TextInputType.number,
              centerText: true,
              onChanged: (v) =>
                  notifier.update((c) => c.copyWith(level: int.tryParse(v) ?? c.level)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'XP',
              controller: _xp,
              keyboardType: TextInputType.number,
              centerText: true,
              onChanged: (v) =>
                  notifier.update((c) => c.copyWith(xp: int.tryParse(v) ?? c.xp)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'SPEED (FT)',
              controller: _speed,
              keyboardType: TextInputType.number,
              centerText: true,
              onChanged: (v) =>
                  notifier.update((c) => c.copyWith(speed: int.tryParse(v) ?? c.speed)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'INIT & HIT DIE',
              controller: _initHd,
              centerText: true,
              onChanged: (v) => notifier.update((c) => c.copyWith(initHitDie: v)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: labeledField(
              label: 'MASTERY EDGES',
              controller: _masteryEdges,
              keyboardType: TextInputType.number,
              centerText: true,
              onChanged: (v) => notifier
                  .update((c) => c.copyWith(masteryEdges: int.tryParse(v) ?? c.masteryEdges)),
            ),
          ),
        ]),

        // ── Attributes ────────────────────────────────────────
        sectionHeader('ATTRIBUTES'),
        _AttrHeader(),
        _AttributeRow(
          label: 'BODY',
          attr: c.body,
          onChanged: (a) => notifier.update((c) => c.copyWith(body: a)),
        ),
        _AttributeRow(
          label: 'AGIL',
          attr: c.agility,
          onChanged: (a) => notifier.update((c) => c.copyWith(agility: a)),
        ),
        _AttributeRow(
          label: 'MIND',
          attr: c.mind,
          onChanged: (a) => notifier.update((c) => c.copyWith(mind: a)),
        ),
        _AttributeRow(
          label: 'PRES',
          attr: c.presence,
          onChanged: (a) => notifier.update((c) => c.copyWith(presence: a)),
        ),
        // ── Hit Points ────────────────────────────────────────
        sectionHeader('HIT POINTS'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HpCounter(
                label: 'CURRENT',
                value: c.currentHp,
                onDecrement: () =>
                    notifier.update((c) => c.copyWith(currentHp: c.currentHp - 1)),
                onIncrement: () =>
                    notifier.update((c) => c.copyWith(currentHp: c.currentHp + 1)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('/', style: TextStyle(fontSize: 28, color: Colors.white38)),
              ),
              _HpCounter(
                label: 'MAX',
                value: c.maxHp,
                onDecrement: () =>
                    notifier.update((c) => c.copyWith(maxHp: c.maxHp - 1)),
                onIncrement: () =>
                    notifier.update((c) => c.copyWith(maxHp: c.maxHp + 1)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('TRAUMA', style: TextStyle(color: Colors.white38, fontSize: 11)),
            const SizedBox(width: 8),
            Checkbox(
              value: c.trauma1,
              onChanged: (v) => notifier.update((c) => c.copyWith(trauma1: v ?? false)),
            ),
            Checkbox(
              value: c.trauma2,
              onChanged: (v) => notifier.update((c) => c.copyWith(trauma2: v ?? false)),
            ),
          ],
        ),
      ],
    );
  }
}

class _AttrHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: const [
          SizedBox(width: 56),
          Expanded(child: Center(child: Text('SCORE', style: style))),
          SizedBox(width: 56, child: Center(child: Text('MASTERY', style: style))),
        ],
      ),
    );
  }
}

class _AttributeRow extends StatefulWidget {
  final String label;
  final Attribute attr;
  final ValueChanged<Attribute> onChanged;

  const _AttributeRow({required this.label, required this.attr, required this.onChanged});

  @override
  State<_AttributeRow> createState() => _AttributeRowState();
}

class _AttributeRowState extends State<_AttributeRow> {
  late TextEditingController _score;

  @override
  void initState() {
    super.initState();
    _score = TextEditingController(text: '${widget.attr.score}');
  }

  @override
  void dispose() {
    _score.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(widget.label,
                style: const TextStyle(
                    color: kGold, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Expanded(
            child: _numField(_score, (v) {
              final s = int.tryParse(v) ?? widget.attr.score;
              widget.onChanged(widget.attr.copyWith(score: s));
            }),
          ),
          SizedBox(
            width: 56,
            child: Center(
              child: Checkbox(
                value: widget.attr.hasMastery,
                onChanged: (v) =>
                    widget.onChanged(widget.attr.copyWith(hasMastery: v ?? false)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numField(TextEditingController ctrl, ValueChanged<String> onChanged) =>
      Center(
        child: SizedBox(
          width: 56,
          child: TextField(
            controller: ctrl,
            onChanged: onChanged,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
            decoration: const InputDecoration(isDense: true),
          ),
        ),
      );
}

class _HpCounter extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _HpCounter({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle, size: 28),
              onPressed: onDecrement,
              color: kGold,
            ),
            Text('$value',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_circle, size: 28),
              onPressed: onIncrement,
              color: kGold,
            ),
          ],
        ),
      ],
    );
  }
}
