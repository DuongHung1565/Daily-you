// Copyright (C) 2026 Demizo and contributors
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'dart:math';

import 'package:daily_you/l10n/generated/app_localizations.dart';
import 'package:daily_you/models/entry.dart';
import 'package:daily_you/web/web_journal_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:intl/intl.dart';

const _moods = [-2, -1, 0, 1, 2];
const _moodFaces = ['😢', '😟', '😐', '🙂', '😄'];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!idbFactoryNativeSupported) {
    runApp(const _StartupError(unavailable: true));
    return;
  }
  try {
    final repository = WebJournalRepository(idbFactoryNative);
    await repository.open();
    final savedLanguage = await repository.languageCode();
    final entries = await repository.entries();
    final tags = await repository.tags();
    runApp(_WebJournalApp(
      repository: repository,
      initialEntries: entries,
      initialTags: tags,
      initialLocale: AppLocalizations.supportedLocales.firstWhere(
        (locale) => locale.toLanguageTag() == savedLanguage,
        orElse: () => const Locale('vi'),
      ),
    ));
  } catch (_) {
    runApp(const _StartupError(unavailable: false));
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.unavailable});

  final bool unavailable;

  @override
  Widget build(BuildContext context) => MaterialApp(
        locale: const Locale('vi'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Builder(builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return Text(
                  unavailable
                      ? l10n.webStorageUnavailable
                      : l10n.webStorageFailure,
                  textAlign: TextAlign.center,
                );
              }),
            ),
          ),
        ),
      );
}

class _WebJournalApp extends StatefulWidget {
  const _WebJournalApp({
    required this.repository,
    required this.initialEntries,
    required this.initialTags,
    required this.initialLocale,
  });

  final WebJournalRepository repository;
  final List<WebJournalRecord> initialEntries;
  final List<String> initialTags;
  final Locale initialLocale;

  @override
  State<_WebJournalApp> createState() => _WebJournalAppState();
}

class _WebJournalAppState extends State<_WebJournalApp> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late List<WebJournalRecord> _entries = widget.initialEntries;
  late List<String> _tags = widget.initialTags;
  late Locale _locale = widget.initialLocale;
  int _tab = 0;
  String _search = '';
  String? _tagFilter;

  AppLocalizations get _l10n => lookupAppLocalizations(_locale);

  Future<void> _reload() async {
    final entries = await widget.repository.entries();
    final tags = await widget.repository.tags();
    if (!mounted) return;
    setState(() {
      _entries = entries;
      _tags = tags;
    });
  }

  void _message(String text) {
    if (!mounted) return;
    _messengerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _edit([WebJournalRecord? record]) async {
    final result = await showDialog<WebJournalRecord>(
      context: _navigatorKey.currentContext!,
      builder: (context) => _EntryEditor(initial: record),
    );
    if (result == null) return;
    try {
      await widget.repository.save(result);
      for (final tag in result.tags) {
        await widget.repository.addTag(tag);
      }
      await _reload();
      _message(_l10n.webEntrySaved);
    } catch (_) {
      _message(_l10n.webStorageFailure);
    }
  }

  Future<void> _delete(WebJournalRecord record) async {
    final confirmed = await showDialog<bool>(
      context: _navigatorKey.currentContext!,
      builder: (dialogContext) => AlertDialog(
        title: Text(_l10n.deleteLogTitle),
        content: Text(_l10n.webDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(_l10n.webCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(_l10n.webDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || record.entry.id == null) return;
    try {
      await widget.repository.deleteEntry(record.entry.id!);
      await _reload();
      _message(_l10n.webEntryDeleted);
    } catch (_) {
      _message(_l10n.webStorageFailure);
    }
  }

  Future<void> _view(WebJournalRecord record) async {
    final action = await showDialog<String>(
      context: _navigatorKey.currentContext!,
      builder: (dialogContext) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 680,
            maxHeight: min(700.0, MediaQuery.sizeOf(dialogContext).height - 48),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd(_locale.languageCode)
                      .format(record.entry.timeCreate),
                  style: Theme.of(dialogContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (record.entry.mood != null)
                          Text(_moodFace(record.entry.mood!),
                              style: const TextStyle(fontSize: 36)),
                        SelectableText(record.entry.text),
                        const SizedBox(height: 12),
                        Wrap(spacing: 8, children: [
                          for (final tag in record.tags) Chip(label: Text(tag)),
                        ]),
                        for (final image in record.images)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(image.bytes,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Text(_l10n.attachmentLoadFailed)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(spacing: 8, children: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(_l10n.webCancel),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(dialogContext, 'delete'),
                    icon: const Icon(Icons.delete_outline),
                    label: Text(_l10n.webDelete),
                  ),
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(dialogContext, 'edit'),
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(_l10n.webEditEntry),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
    if (action == 'edit') await _edit(record);
    if (action == 'delete') await _delete(record);
  }

  Future<void> _export() async {
    try {
      final bytes = await widget.repository.exportBackup();
      await FilePicker.saveFile(
        fileName: 'daily-you-web.json',
        bytes: bytes,
        mimeType: 'application/json',
      );
    } catch (_) {
      _message(_l10n.webExportError);
    }
  }

  Future<void> _import() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: const ['json'],
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      await widget.repository.importBackup(bytes);
      await _reload();
      _message(_l10n.webImportSuccess);
    } on FormatException {
      _message(_l10n.webInvalidBackup);
    } catch (_) {
      _message(_l10n.webImportError);
    }
  }

  Future<void> _changeLanguage(Locale locale) async {
    try {
      await widget.repository.setLanguageCode(locale.toLanguageTag());
      if (!mounted) return;
      setState(() => _locale = locale);
    } catch (_) {
      _message(_l10n.webStorageFailure);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: _messengerKey,
        navigatorKey: _navigatorKey,
        locale: _locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Daily You',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6650A4)),
        ),
        home: Builder(builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          final destinations = [
            NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: l10n.pageHomeTitle),
            NavigationDestination(
                icon: const Icon(Icons.photo_library_outlined),
                selectedIcon: const Icon(Icons.photo_library),
                label: l10n.pageGalleryTitle),
            NavigationDestination(
                icon: const Icon(Icons.bar_chart_outlined),
                selectedIcon: const Icon(Icons.bar_chart),
                label: l10n.pageStatisticsTitle),
            NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: l10n.pageSettingsTitle),
          ];
          return LayoutBuilder(builder: (context, constraints) {
            final wide = constraints.maxWidth >= 800;
            final body = switch (_tab) {
              0 => _home(l10n),
              1 => _gallery(l10n),
              2 => _statistics(l10n),
              _ => _settings(l10n),
            };
            return Scaffold(
              body: SafeArea(
                child: Row(children: [
                  if (wide)
                    NavigationRail(
                      selectedIndex: _tab,
                      onDestinationSelected: (tab) =>
                          setState(() => _tab = tab),
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        for (final destination in destinations)
                          NavigationRailDestination(
                            icon: destination.icon,
                            selectedIcon: destination.selectedIcon,
                            label: Text(destination.label),
                          ),
                      ],
                    ),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1160),
                        child: body,
                      ),
                    ),
                  ),
                ]),
              ),
              bottomNavigationBar: wide
                  ? null
                  : NavigationBar(
                      selectedIndex: _tab,
                      onDestinationSelected: (tab) =>
                          setState(() => _tab = tab),
                      destinations: destinations,
                    ),
            );
          });
        }),
      );

  Widget _page(String title, Widget child) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 18),
          Expanded(child: child),
        ]),
      );

  Widget _home(AppLocalizations l10n) {
    final query = _search.toLowerCase().trim();
    final filtered = _entries.where((record) {
      final matchesText = query.isEmpty ||
          record.entry.text.toLowerCase().contains(query) ||
          record.tags.any((tag) => tag.toLowerCase().contains(query));
      return matchesText &&
          (_tagFilter == null || record.tags.contains(_tagFilter));
    }).toList();
    return _page(
      l10n.pageHomeTitle,
      Column(children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 280,
              child: TextField(
                key: const Key('web-search'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: l10n.webSearch,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (value) => setState(() => _search = value),
              ),
            ),
            DropdownButton<String?>(
              value: _tagFilter,
              hint: Text(l10n.webFilterByTag),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.webAllEntries)),
                for (final tag in _tags)
                  DropdownMenuItem(value: tag, child: Text(tag)),
              ],
              onChanged: (value) => setState(() => _tagFilter = value),
            ),
            FilledButton.icon(
              key: const Key('web-new-entry'),
              onPressed: () => _edit(),
              icon: const Icon(Icons.add),
              label: Text(l10n.webNewEntry),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text(_entries.isEmpty ? l10n.noLogs : l10n.noResults))
              : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final record = filtered[index];
                    return Card(
                      child: ListTile(
                        key: Key('web-entry-${record.entry.id}'),
                        contentPadding: const EdgeInsets.all(16),
                        leading: Text(
                          record.entry.mood == null
                              ? '📝'
                              : _moodFace(record.entry.mood!),
                          style: const TextStyle(fontSize: 30),
                        ),
                        title: Text(
                          record.entry.text.trim().isEmpty
                              ? DateFormat.yMMMMd(_locale.languageCode)
                                  .format(record.entry.timeCreate)
                              : record.entry.text.split('\n').first,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${DateFormat.yMMMMd(_locale.languageCode).format(record.entry.timeCreate)}'
                          '${record.tags.isEmpty ? '' : '  •  ${record.tags.join(', ')}'}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _view(record),
                      ),
                    );
                  },
                ),
        ),
      ]),
    );
  }

  Widget _gallery(AppLocalizations l10n) {
    final photos = [
      for (final record in _entries)
        for (final image in record.images) (record, image),
    ];
    return _page(
      l10n.pageGalleryTitle,
      photos.isEmpty
          ? Center(child: Text(l10n.webGalleryEmpty))
          : LayoutBuilder(builder: (context, constraints) {
              final columns = (constraints.maxWidth / 210).floor().clamp(1, 5);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final (record, image) = photos[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => _view(record),
                      child: Image.memory(image.bytes,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Center(child: Text(l10n.attachmentLoadFailed))),
                    ),
                  );
                },
              );
            }),
    );
  }

  Widget _statistics(AppLocalizations l10n) {
    final counts = {for (final mood in _moods) mood: 0};
    for (final record in _entries) {
      final mood = record.entry.mood;
      if (mood != null && counts.containsKey(mood)) {
        counts[mood] = counts[mood]! + 1;
      }
    }
    final maxCount =
        counts.values.fold<int>(1, (max, value) => value > max ? value : max);
    return _page(
      l10n.pageStatisticsTitle,
      ListView(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(l10n.logCount(_entries.length),
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        const SizedBox(height: 16),
        Text(l10n.tagMoodTitle, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        for (var index = 0; index < _moods.length; index++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(children: [
              SizedBox(width: 48, child: Text(_moodFaces[index])),
              Expanded(
                child: LinearProgressIndicator(
                  value: counts[_moods[index]]! / maxCount,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(
                width: 44,
                child:
                    Text('${counts[_moods[index]]}', textAlign: TextAlign.end),
              ),
            ]),
          ),
      ]),
    );
  }

  Widget _settings(AppLocalizations l10n) => _page(
        l10n.pageSettingsTitle,
        ListView(children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.settingsAppLanguageTitle,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  DropdownButton<Locale>(
                    value: _locale,
                    isExpanded: true,
                    items: [
                      for (final locale in AppLocalizations.supportedLocales)
                        DropdownMenuItem(
                          value: locale,
                          child: Text(switch (locale.languageCode) {
                            'vi' => 'Tiếng Việt',
                            'en' => 'English',
                            _ => locale.toLanguageTag(),
                          }),
                        ),
                    ],
                    onChanged: (locale) {
                      if (locale != null) _changeLanguage(locale);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.settingsBackupRestoreTitle,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    OutlinedButton.icon(
                      onPressed: _export,
                      icon: const Icon(Icons.download_outlined),
                      label: Text(l10n.webBackupExport),
                    ),
                    OutlinedButton.icon(
                      onPressed: _import,
                      icon: const Icon(Icons.upload_file_outlined),
                      label: Text(l10n.webBackupImport),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  Text(l10n.webBrowserDataWarning),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(l10n.webPhotoOnly),
            ),
          ),
        ]),
      );
}

class _EntryEditor extends StatefulWidget {
  const _EntryEditor({this.initial});

  final WebJournalRecord? initial;

  @override
  State<_EntryEditor> createState() => _EntryEditorState();
}

class _EntryEditorState extends State<_EntryEditor> {
  late final TextEditingController _text;
  late final TextEditingController _tags;
  late DateTime _date;
  late int? _mood;
  late final List<WebJournalImage> _images;

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: widget.initial?.entry.text ?? '');
    _tags = TextEditingController(text: widget.initial?.tags.join(', ') ?? '');
    _date = widget.initial?.entry.timeCreate ?? DateTime.now();
    _mood = widget.initial?.entry.mood;
    _images = [...?widget.initial?.images];
  }

  @override
  void dispose() {
    _text.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final file = await FilePicker.pickFile(type: FileType.image);
      if (file == null) return;
      if ((await file.length() ?? 0) > 5 * 1024 * 1024) {
        _show(l10n.webImageTooLarge);
        return;
      }
      final extension = file.extension?.toLowerCase();
      final mimeType = switch (extension) {
        'png' => 'image/png',
        'jpg' || 'jpeg' => 'image/jpeg',
        'webp' => 'image/webp',
        _ => null,
      };
      if (mimeType == null) {
        _show(l10n.webImageUnsupported);
        return;
      }
      final bytes = await file.readAsBytes();
      if (bytes.length > 5 * 1024 * 1024) {
        _show(l10n.webImageTooLarge);
        return;
      }
      if (!mounted) return;
      setState(() => _images.add(
          WebJournalImage(name: file.name, mimeType: mimeType, bytes: bytes)));
    } catch (_) {
      _show(l10n.webImageReadFailure);
    }
  }

  void _show(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;
    if (_text.text.trim().isEmpty && _mood == null && _images.isEmpty) {
      _show(l10n.requiredPrompt);
      return;
    }
    final now = DateTime.now();
    final old = widget.initial?.entry;
    final entry = Entry(
      id: old?.id,
      text: _text.text.trim(),
      mood: _mood,
      timeCreate: _date,
      timeModified: now,
    );
    final tags = _tags.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toSet()
        .toList();
    Navigator.pop(
        context, WebJournalRecord(entry: entry, tags: tags, images: _images));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 680,
          maxHeight: MediaQuery.sizeOf(context).height - 32,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.initial == null ? l10n.webNewEntry : l10n.webEditEntry,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          final selected = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (selected != null) {
                            setState(() => _date = DateTime(
                                  selected.year,
                                  selected.month,
                                  selected.day,
                                  _date.hour,
                                  _date.minute,
                                ));
                          }
                        },
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: Text(DateFormat.yMMMMd(locale.languageCode)
                            .format(_date)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        key: const Key('web-entry-text'),
                        controller: _text,
                        maxLines: 8,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: l10n.writeSomethingHint,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.webMoodQuestion),
                      const SizedBox(height: 8),
                      Wrap(spacing: 8, runSpacing: 8, children: [
                        for (var index = 0; index < _moods.length; index++)
                          ChoiceChip(
                            key: Key('web-mood-${_moods[index]}'),
                            label: Text('${_moodFaces[index]}  '
                                '${_moodLabel(l10n, _moods[index])}'),
                            selected: _mood == _moods[index],
                            onSelected: (_) => setState(() => _mood =
                                _mood == _moods[index] ? null : _moods[index]),
                          ),
                      ]),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _tags,
                        decoration: InputDecoration(
                          labelText: l10n.tagLabel,
                          hintText: l10n.webTagsHint,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: Text(l10n.webPickImage),
                      ),
                      for (var index = 0; index < _images.length; index++)
                        ListTile(
                          leading: Image.memory(
                            _images[index].bytes,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                          title: Text(_images[index].name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            tooltip: l10n.webRemoveImage,
                            icon: const Icon(Icons.close),
                            onPressed: () =>
                                setState(() => _images.removeAt(index)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.webCancel),
                ),
                FilledButton(
                  key: const Key('web-save-entry'),
                  onPressed: _save,
                  child: Text(l10n.webSave),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

String _moodFace(int mood) {
  final index = _moods.indexOf(mood);
  return index < 0 ? '📝' : _moodFaces[index];
}

String _moodLabel(AppLocalizations l10n, int mood) => switch (mood) {
      -2 => l10n.webMoodVeryBad,
      -1 => l10n.webMoodBad,
      0 => l10n.webMoodNeutral,
      1 => l10n.webMoodGood,
      _ => l10n.webMoodGreat,
    };
