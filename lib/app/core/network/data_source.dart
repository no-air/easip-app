import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'api_request.dart';
import 'network_exceptions.dart';

class RemoteDataSource extends GetxService {
  static RemoteDataSource get to => Get.find<RemoteDataSource>();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<T?> execute<T>(ApiRequest<T> request) async {
    try {
      // Get headers asynchronously if they are a Future
      final dynamic headers =
          request.headers is Future ? await request.headers : request.headers;

      final response = await _dio.request<dynamic>(
        request.url,
        data: request.body,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method,
          headers: headers,
          responseType: ResponseType.json,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final dynamic responseData = response.data;
        final String errorMessage;

        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message']?.toString() ?? 'Unknown error';
        } else if (responseData is String) {
          errorMessage = responseData;
        } else {
          errorMessage = 'Server error ${response.statusCode}';
        }

        throw HttpException(
          errorMessage,
          statusCode: response.statusCode,
          data: response.data,
        );
      }

      return request.parseResponse(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('[ERROR] Network error: ${e.message}');
        if (e.response != null) {
          print('[ERROR] Response data: ${e.response?.data}');
          print('[ERROR] Response headers: ${e.response?.headers}');
        }
      }
      throw _handleError(e);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('[ERROR] Unexpected error: $e');
        print('Stack trace: $stackTrace');
      }
      rethrow;
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('연결 시간이 초과되었습니다.');
      case DioExceptionType.badResponse:
        return HttpException(
          '서버 에러: ${error.response?.statusCode}',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.cancel:
        return TimeoutException('요청이 취소되었습니다.');
      case DioExceptionType.connectionError:
        return HttpException('인터넷 연결을 확인해주세요.');
      default:
        return HttpException('네트워크 에러가 발생했습니다: ${error.message}');
    }
  }
}
