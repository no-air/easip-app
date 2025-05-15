import 'package:flutter_config/flutter_config.dart';

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
        _baseUrl = FlutterConfig.get(env.baseUrlKey);
    }
}