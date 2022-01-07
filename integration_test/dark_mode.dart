import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:m_carl/main.dart';

import 'package:m_carl/settings/settings_controller.dart';
import 'package:m_carl/settings/settings_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('toggle dark mode', (WidgetTester tester) async {
      final settingsController = SettingsController(SettingsService());
      await settingsController.loadSettings();

      expect(settingsController.themeMode, ThemeMode.system);

      await tester.pumpWidget(MyApp(
        settingsController: settingsController,
      ));

      final Finder settingsIcon = find.byIcon(Icons.settings);
      expect(settingsIcon, findsOneWidget);
      await tester.tap(settingsIcon);
      await tester.pumpAndSettle();

      final Finder modeSelect = find.byType(DropdownButton<ThemeMode>);
      expect(modeSelect, findsOneWidget);

      await tester.tap(modeSelect);
      await tester.pumpAndSettle();

      final Finder systemChoice = find.text('System Theme');
      final Finder lightChoice = find.text('Light Theme');
      final Finder darkChoice = find.text('Dark Theme');
      expect(systemChoice, findsWidgets);
      expect(lightChoice, findsWidgets);
      expect(darkChoice, findsWidgets);

      await tester.tap(darkChoice.last);
      await tester.pumpAndSettle();

      expect(settingsController.themeMode, ThemeMode.dark);

      await tester.tap(modeSelect);
      await tester.pumpAndSettle();

      await tester.tap(lightChoice.last);
      await tester.pumpAndSettle();

      expect(settingsController.themeMode, ThemeMode.light);
    });
  });
}
