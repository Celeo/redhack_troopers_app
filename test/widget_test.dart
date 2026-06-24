import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:troopers_sheet/providers/character_provider.dart';
import 'package:troopers_sheet/screens/character_sheet_screen.dart';
import 'package:troopers_sheet/theme.dart';

void main() {
  testWidgets('app boots and shows four tabs', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: MaterialApp(
          theme: troopersTheme(),
          home: const CharacterSheetScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('TROOPERS'), findsOneWidget);
    expect(find.text('STATS'), findsOneWidget);
    expect(find.text('SKILLS'), findsOneWidget);
    expect(find.text('COMBAT'), findsOneWidget);
    expect(find.text('GEAR'), findsOneWidget);
  });
}
