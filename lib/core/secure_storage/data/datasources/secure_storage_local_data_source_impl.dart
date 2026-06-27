import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source.dart';

class SecureStorageLocalDataSourceImpl implements SecureStorageLocalDataSource {
  SecureStorageLocalDataSourceImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  final Map<String, StreamController<String?>> _watchControllers = {};

  @override
  Stream<String?> watch(String key) {
    final controller = _watchControllers.putIfAbsent(
      key,
      () => StreamController<String?>.broadcast(),
    );

    unawaited(_emitCurrentValue(key, controller));

    return controller.stream;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
    _watchControllers[key]?.add(value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
    _watchControllers[key]?.add(null);
  }

  Future<void> _emitCurrentValue(
    String key,
    StreamController<String?> controller,
  ) async {
    try {
      final value = await _storage.read(key: key);
      if (!controller.isClosed) {
        controller.add(value);
      }
    } on PlatformException catch (error) {
      if (!controller.isClosed) {
        controller.addError(error);
      }
    }
  }
}
