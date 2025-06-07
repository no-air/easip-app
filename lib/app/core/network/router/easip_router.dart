import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_response.dart';
import 'package:easip_app/app/modules/my/models/user_profile_response.dart';
import 'package:easip_app/app/modules/announcement/model/announcement_response.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';


class EasipRouter {
  static Future<ApiRequest<UserProfileResponse>> getMyProfile() async {
    final token = await TokenStorage.accessToken;
    if (token == null) {
      throw Exception('Access token not found');
    }
    
    return EasipRequest<UserProfileResponse>(
      path: '/v1/me/profile',
      method: HttpMethod.get,
      headers: {
        'accept': 'application/json',
        'X-AUTH-TOKEN': token,
      },
      fromJson: UserProfileResponse.fromJson,
    );
  }

  static Future<ApiRequest<AnnouncementResponse>> getAnnouncements({
    String? keyword,
    int page = 1,
    int size = 10,
  }) async {
    final token = await TokenStorage.accessToken;
    if (token == null) {
      throw Exception('Access token not found');
    }

    final queryParams = {
      'page': page,
      'size': size,
      if (keyword != null) 'keyword': keyword,
    };

    return EasipRequest<AnnouncementResponse>(
      path: '/v1/posts/list',
      method: HttpMethod.get,
      headers: {
        'accept': 'application/json',
        'X-AUTH-TOKEN': token,
      },
      queryParameters: queryParams,
      fromJson: AnnouncementResponse.fromJson,
    );
  }

  static Future<ApiRequest<AnnouncementResponse>> getRegisteredAnnouncements({
    String? keyword,
    int page = 1,
    int size = 10,
  }) async {
    final token = await TokenStorage.accessToken;
    if (token == null) {
      throw Exception('Access token not found');
    }

    final queryParams = {
      'page': page,
      'size': size,
      if (keyword != null) 'keyword': keyword,
    };

    return EasipRequest<AnnouncementResponse>(
      path: '/v1/me/like/posts',
      method: HttpMethod.get,
      headers: {
        'accept': 'application/json',
        'X-AUTH-TOKEN': token,
      },
      queryParameters: queryParams,
      fromJson: AnnouncementResponse.fromJson,
    );
  }

   static Future<ApiRequest<ApiResponse>> deleteAccount() async {
    final token = await TokenStorage.accessToken;
    if (token == null) {
      throw Exception('Access token not found');
    }

    return EasipRequest<ApiResponse>(
      path: '/v1/me',
      method: HttpMethod.delete,
      headers: {
        'accept': 'application/json',
        'X-AUTH-TOKEN': token,
      },
      fromJson: ApiResponse.fromJson,
    );
  }
}

class EasipRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;
  final Map<String, String>? _headers;
  final Map<String, dynamic>? _queryParameters;
  final T Function(Map<String, dynamic>) fromJson;

  EasipRequest({
    required String path,
    required HttpMethod method,
    required this.fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) : _path = path,
       _method = method,
       _body = body,
       _headers = headers,
       _queryParameters = queryParameters;

  @override
  String get baseUrl => EnvConfig().baseUrl;

  @override
  String get path => _path;

  @override
  String get method => _method.value;

  @override
  Map<String, String>? get headers => _headers;

  @override
  Map<String, dynamic>? get queryParameters => _queryParameters;

  @override
  Map<String, dynamic>? get body => _body;

  @override
  T parseResponse(dynamic data) {
    if (data == null) throw Exception('Response data is null');
    if (data is! Map<String, dynamic>) throw Exception('Invalid response format');
    return fromJson(data);
  }
}