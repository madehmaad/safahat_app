import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'logging_interceptor.dart';

httpClientConfig() {
  Get.put(Dio()
    ..interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      request.connectTimeout = 20000 as Duration?;
      request.receiveTimeout = 20000 as Duration?;
      handler.next(request);
    }, onError: (error, handler) async {
      handler.next(error);
    }, onResponse: (response, handler) {
      handler.next(response);
    }))
    ..interceptors.add(LoggingInterceptor()));
}
