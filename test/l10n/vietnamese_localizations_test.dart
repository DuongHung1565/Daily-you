// Copyright (C) 2026 Demizo and contributors
// SPDX-License-Identifier: GPL-3.0-only
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'package:daily_you/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('switching to Vietnamese updates the visible interface',
      (tester) async {
    Widget app(Locale locale) => MaterialApp(
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return Scaffold(
              appBar: AppBar(title: Text(l10n.pageSettingsTitle)),
              body: Column(children: [
                Text(l10n.logCount(2)),
                Text(l10n.deleteTagMessage(2, 'Công việc')),
              ]),
            );
          }),
        );

    await tester.pumpWidget(app(const Locale('en')));
    expect(find.text('Settings'), findsOneWidget);

    await tester.pumpWidget(app(const Locale('vi')));
    await tester.pumpAndSettle();
    expect(find.text('Cài đặt'), findsOneWidget);
    expect(find.text('2 mục nhật ký'), findsOneWidget);
    expect(find.text('Xóa "Công việc"? Thẻ này được dùng trong 2 mục nhật ký.'),
        findsOneWidget);
  });
}
