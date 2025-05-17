import 'package:flutter_config/flutter_config.dart';

enum Environment {
    dev,
    prod,
    test;

    String get baseUrlKey {
        switch (this) {
            case Environment.dev:
                return 'DEV_BASE_URL';
            case Environment.prod:
                return 'PROD_BASE_URL';
            case Environment.test:
                return 'TEST_BASE_URL';
        }
    }

    String get baseUrl {
        switch (this) {
            case Environment.dev:
                return FlutterConfig.get('DEV_BASE_URL');
            case Environment.prod:
                return FlutterConfig.get('PROD_BASE_URL');
            case Environment.test:
                return 'https://jsonplaceholder.typicode.com';
        }
    }
}

final class EnvConfig {
    static final EnvConfig _instance = EnvConfig._internal();
    factory EnvConfig() => _instance;
    EnvConfig._internal();

    late Environment _environment;
    late String _baseUrl;

    String get baseUrl => _baseUrl;
    Environment get environment => _environment;

    void initialize(Environment env) {
        _environment = env;
        _baseUrl = env.baseUrl;
    }
}