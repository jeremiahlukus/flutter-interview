import 'dart:io';

import 'package:dio/dio.dart';

///Define all [API] configurations.
class ApiConfig {
  ApiConfig(
    this._baseUrl, {
    this.bearerToken,
    Options? options,
    int? connectionTimeout,
    int? receiveTimeout,
    int? sendTimeout,
  })  : _connectionTimeout = connectionTimeout ?? 50000,
        _receiveTimeout = receiveTimeout ?? 50000,
        _sendTimeout = sendTimeout ?? 50000,
        _options = options ??
            Options(
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
              },
            );

  Options get options => _options;

  int get connectionTimeout => _connectionTimeout;

  int get receiveTimeout => _receiveTimeout;

  int get sendTimeout => _sendTimeout;

  String get baseUrl => _baseUrl;

  final String _baseUrl;
  final Options _options;

  final int _connectionTimeout;
  final int _receiveTimeout;
  final int _sendTimeout;

  final TokenCallback? bearerToken;
}

typedef TokenCallback = Future<String> Function();
