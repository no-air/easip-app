import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/core/network/test/test_model.dart';

final class TestRequest<T> extends ApiRequest<T> {
  @override
  String get baseUrl => EnvConfig().baseUrl;

  @override
  String get path => '/posts';

  @override
  String get method => HttpMethod.get.value;

  @override
  Map<String, String>? get headers => {};

  @override
  Map<String, dynamic>? get queryParameters => null;

  @override
  dynamic get body => null;

  @override
  T parseResponse(dynamic data) {
    if (data is List) {
      return data
              .map((item) => TestModel.fromJson(item as Map<String, dynamic>))
              .toList()
          as T;
    }
    throw FormatException('Expected List but got ${data.runtimeType}');
  }
}
