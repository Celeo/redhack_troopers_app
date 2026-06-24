import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/gear_item.dart';
import '../models/contact.dart';
import '../providers/character_provider.dart';
import '../screens/character_sheet_screen.dart';
import '../theme.dart';

class GearTab extends ConsumerWidget {
  const GearTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(characterProvider);
    final notifier = ref.read(characterProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ── Gear ──────────────────────────────────────────────
        sectionHeader('GEAR'),
        Row(children: [
          const Text('LOAD', style: TextStyle(color: Colors.white38, fontSize: 11)),
          const SizedBox(width: 8),
          counterRow(
            label: '',
            value: c.currentLoad,
            onDecrement: () =>
                notifier.update((c) => c.copyWith(currentLoad: c.currentLoad - 1)),
            onIncrement: () =>
                notifier.update((c) => c.copyWith(currentLoad: c.currentLoad + 1)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('/ ', style: TextStyle(color: Colors.white38)),
                SizedBox(
                  width: 48,
                  child: _InlineInt(
                    value: c.maxLoad,
                    onChanged: (v) => notifier.update((c) => c.copyWith(maxLoad: v)),
                  ),
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 8),
        ..._buildGearList(c.gear, notifier),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () {
            final updated = [...c.gear, const GearItem()];
            notifier.update((c) => c.copyWith(gear: updated));
          },
          icon: const Icon(Icons.add, color: kGold),
          label: const Text('ADD ITEM', style: TextStyle(color: kGold)),
        ),

        // ── Contacts ──────────────────────────────────────────
        sectionHeader('CONTACTS'),
        _ContactsSection(contacts: c.contacts, notifier: notifier),

        // ── Notes ─────────────────────────────────────────────
        sectionHeader('NOTES'),
        _NotesSection(notifier: notifier),
      ],
    );
  }

  List<Widget> _buildGearList(List<GearItem> gear, CharacterNotifier notifier) {
    return gear.asMap().entries.map((e) {
      final i = e.key;
      final item = e.value;
      return _GearRow(
        key: ValueKey(i),
        item: item,
        onChanged: (updated) {
          final list = [...gear];
          list[i] = updated;
          notifier.update((c) => c.copyWith(gear: list));
        },
        onDelete: () {
          final list = [...gear]..removeAt(i);
          notifier.update((c) => c.copyWith(gear: list));
        },
      );
    }).toList();
  }
}

// ── Gear Row ─────────────────────────────────────────────────

class _GearRow extends StatefulWidget {
  final GearItem item;
  final ValueChanged<GearItem> onChanged;
  final VoidCallback onDelete;

  const _GearRow({super.key, required this.item, required this.onChanged, required this.onDelete});

  @override
  State<_GearRow> createState() => _GearRowState();
}

class _GearRowState extends State<_GearRow> {
  late TextEditingController _name;
  late TextEditingController _load;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.item.name);
    _load = TextEditingController(
        text: widget.item.load == 0 ? '' : '${widget.item.load}');
  }

  @override
  void dispose() {
    _name.dispose();
    _load.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: _name,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(isDense: true, hintText: 'Item name'),
              onChanged: (v) => widget.onChanged(item.copyWith(name: v)),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('UD', style: TextStyle(color: Colors.white38, fontSize: 9)),
              udDropdown(item.ud, (v) => widget.onChanged(item.copyWith(ud: v ?? 0))),
            ],
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('LOAD', style: TextStyle(color: Colors.white38, fontSize: 9)),
                TextField(
                  controller: _load,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(isDense: true),
                  onChanged: (v) =>
                      widget.onChanged(item.copyWith(load: int.tryParse(v) ?? item.load)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18),
            onPressed: widget.onDelete,
            color: Colors.white24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// ── Contacts ─────────────────────────────────────────────────

class _ContactsSection extends StatefulWidget {
  final List<Contact> contacts;
  final CharacterNotifier notifier;

  const _ContactsSection({required this.contacts, required this.notifier});

  @override
  State<_ContactsSection> createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<_ContactsSection> {
  late List<TextEditingController> _names;
  late List<TextEditingController> _occupations;
  late List<TextEditingController> _notes;

  @override
  void initState() {
    super.initState();
    _names = widget.contacts.map((c) => TextEditingController(text: c.name)).toList();
    _occupations =
        widget.contacts.map((c) => TextEditingController(text: c.occupation)).toList();
    _notes = widget.contacts.map((c) => TextEditingController(text: c.notes)).toList();
  }

  @override
  void dispose() {
    for (final group in [_names, _occupations, _notes]) {
      for (final c in group) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _update(int i, Contact Function(Contact) fn) {
    final updated = List<Contact>.from(widget.contacts);
    updated[i] = fn(updated[i]);
    widget.notifier.update((c) => c.copyWith(contacts: updated));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(7, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: labeledField(
                    label: 'NAME',
                    controller: _names[i],
                    onChanged: (v) => _update(i, (c) => c.copyWith(name: v)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: labeledField(
                    label: 'OCCUPATION',
                    controller: _occupations[i],
                    onChanged: (v) => _update(i, (c) => c.copyWith(occupation: v)),
                  ),
                ),
              ]),
              const SizedBox(height: 4),
              labeledField(
                label: 'NOTES',
                controller: _notes[i],
                onChanged: (v) => _update(i, (c) => c.copyWith(notes: v)),
              ),
              const Divider(height: 16),
            ],
          ),
        );
      }),
    );
  }
}

// ── Notes ────────────────────────────────────────────────────

class _NotesSection extends ConsumerStatefulWidget {
  final CharacterNotifier notifier;

  const _NotesSection({required this.notifier});

  @override
  ConsumerState<_NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends ConsumerState<_NotesSection> {
  late TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _notes = TextEditingController(text: ref.read(characterProvider).notes);
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return labeledField(
      label: 'NOTES',
      controller: _notes,
      onChanged: (v) => widget.notifier.update((c) => c.copyWith(notes: v)),
      maxLines: 10,
    );
  }
}

// Shared inline integer widget
class _InlineInt extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _InlineInt({required this.value, required this.onChanged});

  @override
  State<_InlineInt> createState() => _InlineIntState();
}

class _InlineIntState extends State<_InlineInt> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: '${widget.value}');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _ctrl,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
      decoration: const InputDecoration(isDense: true),
      onChanged: (v) {
        final parsed = int.tryParse(v);
        if (parsed != null) widget.onChanged(parsed);
      },
    );
  }
}
