// Copyright (C) 2026 Demizo and contributors
// SPDX-License-Identifier: GPL-3.0-only
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'dart:ui';

import 'package:daily_you/config_provider.dart';
import 'package:daily_you/l10n/generated/app_localizations.dart';

/// Uses the same language choice as the app in background notification tasks.
Locale backgroundLocale() {
  final override = ConfigProvider.instance.getOverrideLanguage();
  if (override != null) return override;

  final languageCode = PlatformDispatcher.instance.locale.languageCode;
  final locale = AppLocalizations.supportedLocales.firstWhere(
    (candidate) => candidate.languageCode == languageCode,
    orElse: () => const Locale('en'),
  );
  return locale;
}

AppLocalizations backgroundAppLocalizations() =>
    lookupAppLocalizations(backgroundLocale());
