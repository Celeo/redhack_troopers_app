import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/character_provider.dart';
import 'screens/character_sheet_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const TroopersApp(),
    ),
  );
}

class TroopersApp extends StatelessWidget {
  const TroopersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TROOPERS',
      theme: troopersTheme(),
      home: const CharacterSheetScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
