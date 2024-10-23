import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'functions.dart';

class LoggingInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      println('LOGGING REQUEST');
      println(
          "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
      println("Headers:");
      options.headers.forEach((k, v) {
        if (kDebugMode) println('$k: $v');
      });
    }

    if (kDebugMode) {
      println("queryParameters:");
      options.queryParameters.forEach((k, v) {
        if (kDebugMode) println('$k: $v');
      });
      println("--> END ${options.method.toUpperCase()}");
      println("Body: ${options.data}");
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      println('LOGGING ERROR');
      println(
          "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
      println("${err.response != null ? err.response?.data : 'Unknown Error'}");
      println("<-- End error");
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      println('LOGGING RESPONSE');
      println(
          "<-- ${response.statusCode} ${((response.requestOptions.baseUrl + response.requestOptions.path))}");
      println("Response: ${response.data}");
      println("<-- END HTTP");
    }
    return handler.next(response);
  }
}
