import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/character.dart';

const _kKey = 'character_v1';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main');
});

final characterProvider = StateNotifierProvider<CharacterNotifier, Character>(
  (ref) => CharacterNotifier(ref.watch(sharedPreferencesProvider)),
);

class CharacterNotifier extends StateNotifier<Character> {
  final SharedPreferences _prefs;

  CharacterNotifier(this._prefs) : super(_load(_prefs));

  static Character _load(SharedPreferences prefs) {
    final json = prefs.getString(_kKey);
    if (json == null) return Character();
    try {
      return Character.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return Character();
    }
  }

  void update(Character Function(Character) updater) {
    state = updater(state);
    _prefs.setString(_kKey, jsonEncode(state.toJson()));
  }

  void reset() {
    state = Character(generation: state.generation + 1);
    _prefs.remove(_kKey);
  }
}
