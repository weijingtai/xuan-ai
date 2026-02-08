import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:sqlite3/wasm.dart';

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  if (kDebugMode) {
    final sqlite = await WasmSqlite3.loadFromUrl(Uri.parse('/sqlite3.wasm'));
    sqlite.registerVirtualFileSystem(InMemoryFileSystem(), makeDefault: true);
  }
}
