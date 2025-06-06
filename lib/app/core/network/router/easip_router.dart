import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/modules/my/models/personal_information_model.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';

class EasipRouter {
  static Future<ApiRequest<PersonalInformationModel>> getMyInformation() async {
    final token = await TokenStorage.accessToken;
    if (token == null) {
      throw Exception('Access token not found');
    }
    
    return MyRequest(
      path: '/v1/me/profile',
      method: HttpMethod.get,
      headers: {
        'accept': 'application/json',
        'X-AUTH-TOKEN': token,
      },
    );
  }
}


class MyRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;
  final Map<String, String>? _headers;

  MyRequest({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) : _path = path,
       _method = method,
       _body = body,
       _headers = headers;

  @override
  String get baseUrl => EnvConfig().baseUrl;

  @override
  String get path => _path;

  @override
  String get method => _method.value;

  @override
  Map<String, String>? get headers => _headers;

  @override
  Map<String, dynamic>? get queryParameters => null;

  @override
  Map<String, dynamic>? get body => _body;

  @override
  T parseResponse(dynamic data) {
    if (data == null) return null as T;
    
    if (T == PersonalInformationModel && data is Map<String, dynamic>) {
      return PersonalInformationModel.fromJson(data) as T;
    }
    
    if (data is T) {
      return data;
    }
    
    throw Exception('Invalid response type: expected $T but got ${data.runtimeType}');
  }
}