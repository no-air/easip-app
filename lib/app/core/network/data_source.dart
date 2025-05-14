import 'dart:convert';
import 'dart:io';

/// HTTP 요청을 실행하고 응답을 처리하는 데이터 소스의 인터페이스

abstract class RemoteDataSource {
  // dynamic을 사용해서 다양한 형태의 API 응답을 처리할 수 있는 클로저
  // dynamic을 받아서 T를 반환하는 함수
  Future<T> fetchPrimitiveData<T>({
    required HttpClientRequest request,
    required T Function(dynamic) fromJson,
  });

  Future<T> fetchObjectData<T>({
    required HttpClientRequest request,
    required T Function(Map<String,dynamic>) fromJson,
  });
}


final class RemoteDataSourceImpl implements RemoteDataSource {
  final HttpClient _client;

  RemoteDataSourceImpl({required HttpClient client}) : _client = client;

  @override
  Future<T> fetchPrimitiveData<T>({
    required HttpClientRequest request,
    required T Function(dynamic) fromJson,
  }) async {
    final responseBody = await _executeRequest(request);
    final data = jsonDecode(responseBody);

    return fromJson(data);
  }

  @override
  Future<T> fetchObjectData<T>({
    required HttpClientRequest request,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final responseBody = await _executeRequest(request);
    final data = jsonDecode(responseBody);

    if (data is List) {
      final List<dynamic> items = data;
      return items.map((item) {
        if (item is! Map<String, dynamic>) {
          throw HttpException('리스트의 각 항목은 Map<String, dynamic> 형태여야 합니다');
        }
        return fromJson(item);
      }).toList() as T;
    } else if (data is Map<String, dynamic>) {
      return fromJson(data);
    } else {
      throw HttpException('응답은 List 또는 Map<String, dynamic> 형태여야 합니다');
    }
  }

  Future<String> _executeRequest(HttpClientRequest request) async {
    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw HttpException(
          '요청이 실패했습니다. 상태 코드: ${response.statusCode}',
          uri: request.uri,
        );
      }
    } on FormatException {
      throw HttpException('응답 데이터 형식이 올바르지 않습니다.');
    } on SocketException catch (e) {
      throw HttpException('네트워크 연결에 실패했습니다: ${e.message}');
    } catch (e) {
      throw HttpException('예상치 못한 오류가 발생했습니다: ${e.toString()}');
    }
  }
}
