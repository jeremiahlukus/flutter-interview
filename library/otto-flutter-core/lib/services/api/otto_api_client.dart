import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:otto_flutter_core/config/service/api_config.dart';

class OttoApiClient {
  OttoApiClient(this._apiConfig, [this.interceptors]);

  final ApiConfig _apiConfig;
  final List<Interceptor>? interceptors;

  ApiConfig get apiConfig => _apiConfig;

  Dio ottoDio() {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: _apiConfig.baseUrl,
        connectTimeout: _apiConfig.connectionTimeout,
        receiveTimeout: _apiConfig.receiveTimeout,
        sendTimeout: _apiConfig.sendTimeout,
        headers: _apiConfig.options.headers,
      ),
    );

    if (interceptors != null && interceptors!.isNotEmpty) {
      _dio.interceptors
        ..clear()
        ..addAll(interceptors!);
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true,
        ),
      );
    }

    return _dio;
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    int? testStatusCode,
  }) async {
    Response response;
    try {
      response = await ottoDio().get(
        url,
        queryParameters: queryParameters,
        options: await _getOptions(headers, testStatusCode: testStatusCode),
      );
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
    int? testStatusCode,
  }) async {
    Response response;
    try {
      response = await ottoDio().post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: await _getOptions(headers, testStatusCode: testStatusCode),
      );
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
    int? testStatusCode,
  }) async {
    Response response;
    try {
      response = await ottoDio().put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: await _getOptions(headers, testStatusCode: testStatusCode),
      );
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
    int? testStatusCode,
  }) async {
    Response response;
    try {
      response = await ottoDio().patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: await _getOptions(headers, testStatusCode: testStatusCode),
      );
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
    int? testStatusCode,
  }) async {
    Response response;
    try {
      response = await ottoDio().delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: await _getOptions(headers, testStatusCode: testStatusCode),
      );
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<Options> _getOptions(
    Map<String, dynamic>? customHeaders, {
    int? testStatusCode,
  }) async {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      /* if (kDebugMode) ...{'x-mock-response-code': testStatusCode ?? 200}, */
      if (customHeaders != null) ...customHeaders,
    };

    if (_apiConfig.bearerToken != null) {
      final token = await _apiConfig.bearerToken!();
      if (token.isNotEmpty) {
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
    }

    return Options(
      headers: headers,
    );
  }
}
