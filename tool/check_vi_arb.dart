// Copyright (C) 2026 Demizo and contributors
// SPDX-License-Identifier: GPL-3.0-only
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'dart:convert';
import 'dart:io';

void main() {
  final english = _readArb('lib/l10n/intl_en.arb');
  final vietnamese = _readArb('lib/l10n/intl_vi.arb');
  final englishKeys = english.keys.where((key) => !key.startsWith('@')).toSet();
  final vietnameseKeys =
      vietnamese.keys.where((key) => !key.startsWith('@')).toSet();
  final englishMetadata =
      english.keys.where((key) => key.startsWith('@')).toSet();
  final vietnameseMetadata =
      vietnamese.keys.where((key) => key.startsWith('@')).toSet();
  final missing = englishKeys.difference(vietnameseKeys);
  final extra = vietnameseKeys.difference(englishKeys);
  final errors = <String>[];

  if (missing.isNotEmpty) errors.add('Missing keys: ${missing.join(', ')}');
  if (extra.isNotEmpty) errors.add('Extra keys: ${extra.join(', ')}');
  if (englishMetadata.difference(vietnameseMetadata).isNotEmpty) {
    errors.add('Missing metadata keys: '
        '${englishMetadata.difference(vietnameseMetadata).join(', ')}');
  }
  if (vietnameseMetadata.difference(englishMetadata).isNotEmpty) {
    errors.add('Extra metadata keys: '
        '${vietnameseMetadata.difference(englishMetadata).join(', ')}');
  }

  for (final key in englishKeys.intersection(vietnameseKeys)) {
    final original = english[key] as String;
    final translation = vietnamese[key] as String;
    if (translation.trim().isEmpty) errors.add('Empty translation: $key');
    if (!_sameTokens(original, translation, _placeholder)) {
      errors.add('Placeholder mismatch: $key');
    }
    if (!_sameTokens(original, translation, _selector)) {
      errors.add('Plural/select branch mismatch: $key');
    }
    if (english.containsKey('@$key') &&
        jsonEncode(english['@$key']) != jsonEncode(vietnamese['@$key'])) {
      errors.add('Metadata mismatch: $key');
    }
  }

  stdout.writeln(
    'English: ${englishKeys.length}, Vietnamese: ${vietnameseKeys.length}, '
    'missing: ${missing.length}, extra: ${extra.length}, errors: ${errors.length}',
  );
  for (final error in errors) {
    stderr.writeln(error);
  }
  if (errors.isNotEmpty) exitCode = 1;
}

Map<String, dynamic> _readArb(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

final _placeholder = RegExp(r'\{\s*([A-Za-z]\w*)\s*(?=[,}])');
final _selector = RegExp(r'(?<!\w)(?:=\d+|one|other|zero|two|few|many)\{');

bool _sameTokens(String first, String second, RegExp pattern) {
  final firstTokens =
      pattern.allMatches(first).map((match) => match[0]).toList()..sort();
  final secondTokens =
      pattern.allMatches(second).map((match) => match[0]).toList()..sort();
  return jsonEncode(firstTokens) == jsonEncode(secondTokens);
}
