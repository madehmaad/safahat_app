// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:dr_alshaal/models/base_response/base_response.dart';

abstract class BaseRepository {
  Future<BaseResponse<T>> catchError<T>(e) async {
    var response;
    var message;
    if (e is DioError) {
      if (e.response != null && e.response!.data is Map) {
        response = e.response!.data as Map<String, dynamic>;
      }
      if (response != null) message = response['message'];
      message ??= e.message;
    } else {
      message = e.toString();
    }
    return BaseResponse<T>(message: message, data: null, success: false);
  }
}
