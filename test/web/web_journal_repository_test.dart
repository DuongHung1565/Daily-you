// Copyright (C) 2026 Demizo and contributors
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'dart:typed_data';

import 'package:daily_you/models/entry.dart';
import 'package:daily_you/web/web_journal_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb_client_memory.dart';

void main() {
  test('entries, images, tags and language survive repository reopen',
      () async {
    final factory = newIdbFactoryMemory();
    final first = WebJournalRepository(factory);
    await first.open();
    final created = await first.save(WebJournalRecord(
      entry: Entry(
        text: 'Một ngày đáng nhớ',
        mood: 2,
        timeCreate: DateTime(2026, 10, 26),
        timeModified: DateTime(2026, 10, 26),
      ),
      tags: const ['Gia đình'],
      images: [
        WebJournalImage(
          name: 'anh.png',
          mimeType: 'image/png',
          bytes: Uint8List.fromList([1, 2, 3]),
        ),
      ],
    ));
    await first.addTag('Gia đình');
    await first.setLanguageCode('vi');
    first.close();

    final reopened = WebJournalRepository(factory);
    await reopened.open();
    final records = await reopened.entries();
    expect(records, hasLength(1));
    expect(records.single.entry.id, created.entry.id);
    expect(records.single.entry.text, 'Một ngày đáng nhớ');
    expect(records.single.entry.mood, 2);
    expect(records.single.tags, ['Gia đình']);
    expect(records.single.images.single.bytes, [1, 2, 3]);
    expect(await reopened.tags(), ['Gia đình']);
    expect(await reopened.languageCode(), 'vi');

    await reopened.save(records.single.copyWith(
      entry: records.single.entry.copy(text: 'Đã chỉnh sửa', mood: -1),
    ));
    expect((await reopened.entries()).single.entry.text, 'Đã chỉnh sửa');
    expect((await reopened.entries()).single.entry.mood, -1);
    await reopened.deleteEntry(created.entry.id!);
    expect(await reopened.entries(), isEmpty);
    reopened.close();
  });

  test('Web backup restores entries without deleting existing data', () async {
    final source = WebJournalRepository(newIdbFactoryMemory());
    await source.open();
    await source.save(WebJournalRecord(
      entry: Entry(
        text: 'Nguồn',
        timeCreate: DateTime(2026, 10, 25),
        timeModified: DateTime(2026, 10, 25),
      ),
    ));
    final backup = await source.exportBackup();

    final target = WebJournalRepository(newIdbFactoryMemory());
    await target.open();
    await target.save(WebJournalRecord(
      entry: Entry(
        text: 'Có sẵn',
        timeCreate: DateTime(2026, 10, 26),
        timeModified: DateTime(2026, 10, 26),
      ),
    ));
    expect(await target.importBackup(backup), 1);
    expect((await target.entries()).map((record) => record.entry.text),
        containsAll(['Nguồn', 'Có sẵn']));
    expect(() => target.importBackup(Uint8List.fromList([1, 2, 3])),
        throwsFormatException);
    source.close();
    target.close();
  });
}
