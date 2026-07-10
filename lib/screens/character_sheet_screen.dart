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

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Character?'),
        content: const Text(
            'This will permanently erase all saved data and start fresh. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('RESET'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(characterProvider.notifier).reset();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(characterProvider.select((c) => c.name));
    final generation = ref.watch(characterProvider.select((c) => c.generation));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name.isEmpty ? 'Troopers: Diver Edition' : name.toUpperCase(),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'reset') _confirmReset(context, ref);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'reset', child: Text('Reset character')),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'STATS'),
              Tab(text: 'SKILLS'),
              Tab(text: 'COMBAT'),
              Tab(text: 'GEAR'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StatsTab(key: ValueKey(generation)),
            SkillsTab(key: ValueKey(('skills', generation))),
            CombatTab(key: ValueKey(('combat', generation))),
            GearTab(key: ValueKey(('gear', generation))),
          ],
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
  bool centerText = false,
}) => Column(
  crossAxisAlignment: centerText ? CrossAxisAlignment.center : CrossAxisAlignment.start,
  children: [
    SizedBox(
      height: 28,
      width: double.infinity,
      child: Align(
        alignment: centerText ? Alignment.bottomCenter : Alignment.bottomLeft,
        child: Text(
          label,
          textAlign: centerText ? TextAlign.center : TextAlign.start,
          style: const TextStyle(color: Colors.white38, fontSize: 10),
        ),
      ),
    ),
    TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      style: const TextStyle(fontSize: 14),
      decoration: const InputDecoration(border: UnderlineInputBorder()),
    ),
  ],
);
