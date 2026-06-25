import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/character_provider.dart';
import '../theme.dart';
import '../widgets/stats_tab.dart';
import '../widgets/skills_tab.dart';
import '../widgets/combat_tab.dart';
import '../widgets/gear_tab.dart';

class CharacterSheetScreen extends ConsumerWidget {
  const CharacterSheetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(characterProvider.select((c) => c.name));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name.isEmpty ? 'Troopers: Diver Edition' : name.toUpperCase(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'STATS'),
              Tab(text: 'SKILLS'),
              Tab(text: 'COMBAT'),
              Tab(text: 'GEAR'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [StatsTab(), SkillsTab(), CombatTab(), GearTab()],
        ),
      ),
    );
  }
}

// Shared helpers used across tab widgets

Widget sectionHeader(String title) => Padding(
  padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
  child: Container(
    width: double.infinity,
    color: kGold,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 13,
        letterSpacing: 2,
      ),
    ),
  ),
);

Widget labeledField({
  required String label,
  required TextEditingController controller,
  required ValueChanged<String> onChanged,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
    TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: const InputDecoration(border: UnderlineInputBorder()),
    ),
  ],
);

Widget counterRow({
  required String label,
  required int value,
  required VoidCallback onDecrement,
  required VoidCallback onIncrement,
  Widget? trailing,
}) => Row(
  children: [
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
    const SizedBox(width: 8),
    IconButton(
      icon: const Icon(Icons.remove_circle_outline, size: 20),
      onPressed: onDecrement,
      color: kGold,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    ),
    const SizedBox(width: 6),
    Text(
      '$value',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const SizedBox(width: 6),
    IconButton(
      icon: const Icon(Icons.add_circle_outline, size: 20),
      onPressed: onIncrement,
      color: kGold,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    ),
    if (trailing != null) ...[const SizedBox(width: 8), trailing],
  ],
);

const _dieSizes = [0, 4, 6, 8, 10, 12];

Widget udDropdown(int value, ValueChanged<int?> onChanged) =>
    DropdownButton<int>(
      value: value,
      isDense: true,
      dropdownColor: kSurface,
      underline: Container(height: 1, color: Colors.white24),
      items: _dieSizes
          .map(
            (d) => DropdownMenuItem(
              value: d,
              child: Text(
                d == 0 ? '—' : 'd$d',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
