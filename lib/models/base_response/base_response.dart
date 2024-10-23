import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  dynamic success;
  dynamic message;
  T? data;
  BaseResponse({this.success, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, (Object? json) {
        try {
          return fromJsonT(json);
        } catch (e) {
          return fromJsonT(<String, dynamic>{});
        }
      });

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseToJson(this, toJsonT);
}
