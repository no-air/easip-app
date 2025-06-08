import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment {
  dev,
  prod;

  String get baseUrlKey {
    switch (this) {
      case Environment.dev:
        return 'DEV_BASE_URL';
      case Environment.prod:
        return 'PROD_BASE_URL';
    }
  }

  String get baseUrl {
    switch (this) {
      case Environment.dev:
        return dotenv.env['DEV_BASE_URL'] ?? '';
      case Environment.prod:
        return dotenv.env['PROD_BASE_URL'] ?? '';
    }
  }
}

final class EnvConfig {
  static final EnvConfig _instance = EnvConfig._internal();
  factory EnvConfig() => _instance;

  EnvConfig._internal();

  Environment? _environment;
  String? _baseUrl;
  bool _isInitialized = false;

  String get baseUrl {
    if (!_isInitialized) {
      throw StateError('EnvConfig has not been initialized yet');
    }
    return _baseUrl!;
  }

  Environment get environment {
    if (!_isInitialized) {
      throw StateError('EnvConfig has not been initialized yet');
    }
    return _environment!;
  }

  Future<void> initialize(Environment env) async {
    if (_isInitialized) return Future.value();

    // 여기서 비동기 작업 수행
    await Future.delayed(const Duration(milliseconds: 100)); // 예시

    _environment = env;
    _baseUrl = env.baseUrl;
    _isInitialized = true;

    return Future.value();
  }

  bool get isInitialized => _isInitialized;
}
