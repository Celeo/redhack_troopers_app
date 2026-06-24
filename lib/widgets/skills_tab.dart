import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/skill_entry.dart';
import '../providers/character_provider.dart';
import '../screens/character_sheet_screen.dart';
import '../theme.dart';

class SkillsTab extends ConsumerWidget {
  const SkillsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ── Skills ────────────────────────────────────────────
        sectionHeader('SKILLS'),
        _SkillHeader(),
        ...c.skills.asMap().entries.map((e) {
          final i = e.key;
          final skill = e.value;
          final total1 = skill.ranks + c.attrMod(skill.attribute);
          final total2 = skill.attribute2 != null
              ? skill.ranks + c.attrMod(skill.attribute2!)
              : null;
          return _SkillRow(
            skill: skill,
            total1: total1,
            total2: total2,
            onRanksChanged: (ranks) {
              final updated = List<SkillEntry>.from(c.skills);
              updated[i] = skill.copyWith(ranks: ranks);
              notifier.update((c) => c.copyWith(skills: updated));
            },
          );
        }),

        // ── Training ──────────────────────────────────────────
        sectionHeader('TRAINING'),
        _TrainingSection(training: c.training, notifier: notifier),
      ],
    );
  }
}

class _SkillHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: const [
          Expanded(flex: 3, child: Text('SKILL', style: style)),
          SizedBox(width: 64, child: Center(child: Text('ATTR', style: style))),
          SizedBox(width: 56, child: Center(child: Text('RANKS', style: style))),
          SizedBox(width: 48, child: Center(child: Text('TOTAL', style: style))),
        ],
      ),
    );
  }
}

class _SkillRow extends StatefulWidget {
  final SkillEntry skill;
  final int total1;
  final int? total2;
  final ValueChanged<int> onRanksChanged;

  const _SkillRow({
    required this.skill,
    required this.total1,
    this.total2,
    required this.onRanksChanged,
  });

  @override
  State<_SkillRow> createState() => _SkillRowState();
}

class _SkillRowState extends State<_SkillRow> {
  late TextEditingController _ranks;

  @override
  void initState() {
    super.initState();
    _ranks = TextEditingController(text: '${widget.skill.ranks}');
  }

  @override
  void dispose() {
    _ranks.dispose();
    super.dispose();
  }

  String get _attrLabel {
    final a2 = widget.skill.attribute2;
    return a2 != null ? '${widget.skill.attribute}/$a2' : widget.skill.attribute;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.skill.name,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(widget.skill.subtitle,
                    style: const TextStyle(fontSize: 10, color: Colors.white38)),
              ],
            ),
          ),
          SizedBox(
            width: 64,
            child: Center(
              child: Text(_attrLabel,
                  style: const TextStyle(color: kGold, fontSize: 10)),
            ),
          ),
          SizedBox(
            width: 56,
            child: Center(
              child: SizedBox(
                width: 40,
                child: TextField(
                  controller: _ranks,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(isDense: true),
                  onChanged: (v) =>
                      widget.onRanksChanged(int.tryParse(v) ?? widget.skill.ranks),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: Center(
              child: widget.total2 != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${widget.total1}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold, color: kGoldLight)),
                        Text('${widget.total2}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold, color: kGoldLight)),
                      ],
                    )
                  : Text('${widget.total1}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: kGoldLight)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrainingSection extends ConsumerStatefulWidget {
  final List<String> training;
  final CharacterNotifier notifier;

  const _TrainingSection({required this.training, required this.notifier});

  @override
  ConsumerState<_TrainingSection> createState() => _TrainingSectionState();
}

class _TrainingSectionState extends ConsumerState<_TrainingSection> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        widget.training.map((t) => TextEditingController(text: t)).toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(7, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 8),
                color: i.isEven ? kGold.withAlpha(180) : kSurface,
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: i.isEven ? Colors.black : kGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controllers[i],
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(isDense: true),
                  onChanged: (v) {
                    final updated = List<String>.from(widget.training);
                    updated[i] = v;
                    widget.notifier.update((c) => c.copyWith(training: updated));
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
