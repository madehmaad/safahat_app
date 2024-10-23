import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationModel<T> {
  int? currentPage;
  List<T> data;
  dynamic nextPageUrl;

  PaginationModel(this.currentPage, this.data, this.nextPageUrl);
  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationModelFromJson(json, (Object? json) {
        try {
          return fromJsonT(json);
        } catch (e) {
          return fromJsonT(<String, dynamic>{});
        }
      });

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PaginationModelToJson(this, toJsonT);
}
