// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel<T> _$PaginationModelFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationModel<T>(
      json['current_page'] as int?,
      (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      json['next_page_url'],
    );

Map<String, dynamic> _$PaginationModelToJson<T>(
  PaginationModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data.map(toJsonT).toList(),
      'next_page_url': instance.nextPageUrl,
    };
