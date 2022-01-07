import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:m_carl/main.dart';

import 'package:m_carl/settings/settings_controller.dart';
import 'package:m_carl/settings/settings_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();
    await tester.pumpWidget(MyApp(
      settingsController: settingsController,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    expect(find.byIcon(Icons.settings), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    final Finder modeSelect = find.byType(DropdownButton<ThemeMode>);
    final Finder settingsTitle = find.text('Settings');

    await tester.pump();

    expect(modeSelect, findsOneWidget);
    expect(settingsTitle, findsOneWidget);

    await tester.tap(modeSelect);

    final Finder systemChoice = find.text('System Theme');
    final Finder lightChoice = find.text('Light Theme');
    final Finder darkChoice = find.text('Dark Theme');

    await tester.pump();

    expect(systemChoice, findsWidgets);
    expect(lightChoice, findsWidgets);
    expect(darkChoice, findsWidgets);
  });
}
