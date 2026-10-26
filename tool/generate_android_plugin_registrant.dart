// Copyright (C) 2026 Demizo and contributors
// SPDX-License-Identifier: GPL-3.0-only
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

// On Windows without symlink permission, `flutter pub get` can resolve
// packages but stop before generating the Android plugin registrant.
// Regenerate only that ignored build input from Flutter's plugin metadata.
import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final metadata =
      jsonDecode(File('.flutter-plugins-dependencies').readAsStringSync())
          as Map<String, dynamic>;
  final plugins =
      (metadata['plugins'] as Map<String, dynamic>)['android'] as List<dynamic>;
  final registrations = <(String, String)>[];

  for (final plugin in plugins.cast<Map<String, dynamic>>()) {
    final root = plugin['path'] as String;
    final pubspec = loadYaml(File('$root${Platform.pathSeparator}pubspec.yaml')
        .readAsStringSync()) as YamlMap;
    final flutter = pubspec['flutter'] as YamlMap?;
    final pluginSection = flutter?['plugin'] as YamlMap?;
    final platforms = pluginSection?['platforms'] as YamlMap?;
    final android = platforms?['android'] as YamlMap?;
    final javaPackage = android?['package'] as String?;
    final javaClass = android?['pluginClass'] as String?;
    if (javaPackage != null && javaClass != null && javaClass.isNotEmpty) {
      registrations.add((plugin['name'] as String, '$javaPackage.$javaClass'));
    }
  }

  final content =
      StringBuffer('''// Generated from .flutter-plugins-dependencies by
// tool/generate_android_plugin_registrant.dart. Do not edit by hand.
package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;

@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";

  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
''');
  for (final (name, javaClass) in registrations) {
    content.writeln('    try {');
    content.writeln('      flutterEngine.getPlugins().add(new $javaClass());');
    content.writeln('    } catch (Exception e) {');
    content.writeln('      Log.e(TAG, "Error registering plugin $name", e);');
    content.writeln('    }');
  }
  content.writeln('  }');
  content.writeln('}');

  final output = File(
      'android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java');
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(content.toString());
  stdout.writeln(
      'Generated ${registrations.length} Android plugin registrations.');
}
