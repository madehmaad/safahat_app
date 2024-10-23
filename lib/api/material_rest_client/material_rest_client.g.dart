// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MaterialRestClient implements MaterialRestClient {
  _MaterialRestClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse<MaterialModel>> getMaterial({required slug}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<MaterialModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'material/${slug}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<MaterialModel>.fromJson(
      _result.data!,
      (json) => MaterialModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<PaginationModel<Seriese>>> getSeries({
    required page,
    type,
    topic,
    orderBy,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'type': type,
      r'topic': topic,
      r'order_by': orderBy,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<PaginationModel<Seriese>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'serieses_paginate/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<PaginationModel<Seriese>>.fromJson(
      _result.data!,
      (json) => PaginationModel<Seriese>.fromJson(
        json as Map<String, dynamic>,
        (json) => Seriese.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<BaseResponse<PaginationModel<MaterialModel>>> getMaterials({
    required page,
    seriesId,
    orderBy,
    type,
    topic,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'series_id': seriesId,
      r'order_by': orderBy,
      r'type_id': type,
      r'topic_id': topic,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<PaginationModel<MaterialModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'get_series_materials/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<PaginationModel<MaterialModel>>.fromJson(
      _result.data!,
      (json) => PaginationModel<MaterialModel>.fromJson(
        json as Map<String, dynamic>,
        (json) => MaterialModel.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
