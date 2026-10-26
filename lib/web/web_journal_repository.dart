// Copyright (C) 2026 Demizo and contributors
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'dart:convert';
import 'dart:typed_data';

import 'package:daily_you/models/entry.dart';
import 'package:idb_shim/idb.dart';

/// A browser database kept separate from the native SQLite database.
/// The same [Entry] fields and mood scale are used on both platforms.
class WebJournalRepository {
  WebJournalRepository(this.factory);

  static const databaseName = 'daily_you_web';
  static const _entriesStore = 'entries';
  static const _tagsStore = 'tags';
  static const _settingsStore = 'settings';

  final IdbFactory factory;
  Database? _database;

  Future<void> open() async {
    _database ??= await factory.open(
      databaseName,
      version: 1,
      onUpgradeNeeded: (event) {
        final database = event.database;
        if (!database.objectStoreNames.contains(_entriesStore)) {
          database.createObjectStore(_entriesStore, autoIncrement: true);
        }
        if (!database.objectStoreNames.contains(_tagsStore)) {
          database.createObjectStore(_tagsStore);
        }
        if (!database.objectStoreNames.contains(_settingsStore)) {
          database.createObjectStore(_settingsStore);
        }
      },
    );
  }

  Database get _db => _database ?? (throw StateError('Database is not open'));

  Future<List<WebJournalRecord>> entries() async {
    final transaction = _db.transaction(_entriesStore, idbModeReadOnly);
    final store = transaction.objectStore(_entriesStore);
    final valuesFuture = store.getAll();
    final keysFuture = store.getAllKeys();
    final values = await valuesFuture;
    final keys = await keysFuture;
    await transaction.completed;
    final result = <WebJournalRecord>[
      for (var index = 0; index < values.length; index++)
        WebJournalRecord.fromMap(
          Map<String, Object?>.from(values[index] as Map),
          keys[index] as int,
        ),
    ];
    result.sort((a, b) => b.entry.timeCreate.compareTo(a.entry.timeCreate));
    return result;
  }

  Future<WebJournalRecord> save(WebJournalRecord record) async {
    final transaction = _db.transaction(_entriesStore, idbModeReadWrite);
    final store = transaction.objectStore(_entriesStore);
    final id = record.entry.id == null
        ? await store.add(record.toMap()) as int
        : await store.put(record.toMap(), record.entry.id) as int;
    await transaction.completed;
    return record.copyWith(entry: record.entry.copy(id: id));
  }

  Future<void> deleteEntry(int id) async {
    final transaction = _db.transaction(_entriesStore, idbModeReadWrite);
    await transaction.objectStore(_entriesStore).delete(id);
    await transaction.completed;
  }

  Future<List<String>> tags() async {
    final transaction = _db.transaction(_tagsStore, idbModeReadOnly);
    final values = await transaction.objectStore(_tagsStore).getAll();
    await transaction.completed;
    final names = values
        .map((value) => (value as Map)['name'] as String)
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return names;
  }

  Future<void> addTag(String name) async {
    final normalized = name.trim();
    if (normalized.isEmpty) return;
    final transaction = _db.transaction(_tagsStore, idbModeReadWrite);
    await transaction
        .objectStore(_tagsStore)
        .put({'name': normalized}, normalized);
    await transaction.completed;
  }

  Future<String?> languageCode() async {
    final transaction = _db.transaction(_settingsStore, idbModeReadOnly);
    final value =
        await transaction.objectStore(_settingsStore).getObject('locale');
    await transaction.completed;
    return (value as Map?)?['value'] as String?;
  }

  Future<void> setLanguageCode(String code) async {
    final transaction = _db.transaction(_settingsStore, idbModeReadWrite);
    await transaction
        .objectStore(_settingsStore)
        .put({'value': code}, 'locale');
    await transaction.completed;
  }

  Future<Uint8List> exportBackup() async {
    final records = await entries();
    final payload = {
      'format': 'daily-you-web',
      'version': 1,
      'entries': [
        for (final record in records)
          {
            ...record.entry.toJson(),
            'tags': record.tags,
            'images': [
              for (final image in record.images)
                {
                  'name': image.name,
                  'mimeType': image.mimeType,
                  'bytes': base64Encode(image.bytes),
                },
            ],
          },
      ],
      'tags': await tags(),
    };
    return Uint8List.fromList(utf8.encode(jsonEncode(payload)));
  }

  /// Imports a Web backup as new entries, leaving existing entries intact.
  Future<int> importBackup(Uint8List bytes) async {
    if (bytes.length > 50 * 1024 * 1024) {
      throw const FormatException('Backup is too large');
    }
    final raw = jsonDecode(utf8.decode(bytes));
    if (raw is! Map ||
        raw['format'] != 'daily-you-web' ||
        raw['version'] != 1 ||
        raw['entries'] is! List ||
        raw['tags'] is! List) {
      throw const FormatException('Invalid Daily You Web backup');
    }
    final imported = <WebJournalRecord>[];
    for (final item in raw['entries'] as List) {
      final map = Map<String, Object?>.from(item as Map);
      final original = Entry.fromJson(map);
      final images = <WebJournalImage>[];
      for (final imageRaw in (map['images'] as List?) ?? const []) {
        final image = Map<String, Object?>.from(imageRaw as Map);
        final data = base64Decode(image['bytes'] as String);
        if (data.length > 5 * 1024 * 1024) {
          throw const FormatException('Image is too large');
        }
        images.add(WebJournalImage(
          name: image['name'] as String,
          mimeType: image['mimeType'] as String,
          bytes: data,
        ));
      }
      imported.add(WebJournalRecord(
        entry: Entry(
          text: original.text,
          mood: original.mood,
          timeCreate: original.timeCreate,
          timeModified: original.timeModified,
        ),
        tags: (map['tags'] as List).cast<String>(),
        images: images,
      ));
    }
    final tagNames = (raw['tags'] as List).cast<String>();
    for (final tag in tagNames) {
      await addTag(tag);
    }
    for (final record in imported) {
      await save(record);
    }
    return imported.length;
  }

  void close() {
    _database?.close();
    _database = null;
  }
}

class WebJournalRecord {
  const WebJournalRecord({
    required this.entry,
    this.tags = const [],
    this.images = const [],
  });

  final Entry entry;
  final List<String> tags;
  final List<WebJournalImage> images;

  WebJournalRecord copyWith({
    Entry? entry,
    List<String>? tags,
    List<WebJournalImage>? images,
  }) =>
      WebJournalRecord(
        entry: entry ?? this.entry,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );

  Map<String, Object?> toMap() => {
        ...entry.toJson(),
        'tags': tags,
        'images': [for (final image in images) image.toMap()],
      };

  factory WebJournalRecord.fromMap(Map<String, Object?> map, int id) =>
      WebJournalRecord(
        entry: Entry.fromJson(map).copy(id: id),
        tags: (map['tags'] as List?)?.cast<String>() ?? const [],
        images: [
          for (final raw in (map['images'] as List?) ?? const [])
            WebJournalImage.fromMap(Map<String, Object?>.from(raw as Map)),
        ],
      );
}

class WebJournalImage {
  const WebJournalImage({
    required this.name,
    required this.mimeType,
    required this.bytes,
  });

  final String name;
  final String mimeType;
  final Uint8List bytes;

  Map<String, Object?> toMap() => {
        'name': name,
        'mimeType': mimeType,
        'bytes': bytes,
      };

  factory WebJournalImage.fromMap(Map<String, Object?> map) => WebJournalImage(
        name: map['name'] as String,
        mimeType: map['mimeType'] as String,
        bytes: map['bytes'] as Uint8List,
      );
}
