// lib/core/services/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SecureStorageService)
class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'token';

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  @override
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}

abstract class SecureStorageService {
  Future<void> saveToken(String token);
  Future<String?> readToken();
  Future<void> deleteToken();
  Future<void> deleteAllData();
}
