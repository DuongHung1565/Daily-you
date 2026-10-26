// Copyright (C) 2026 Demizo and contributors
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Additional terms under GPLv3 section 7 apply; see ADDITIONAL_TERMS.md.

import 'main_native.dart' if (dart.library.js_interop) 'web/main_web.dart'
    as platform;

Future<void> main() async => platform.main();
