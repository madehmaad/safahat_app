import 'package:json_annotation/json_annotation.dart';

import '../category/category.dart';

part 'home_type.g.dart';

@JsonSerializable()
class HomeType {
  int? id;
  int? itemsLimit;
  int? materialTypeId;
  dynamic title;
  dynamic createdAt;
  dynamic updatedAt;
  Category? materialType;

  HomeType(
      this.id, this.title, this.updatedAt, this.createdAt, this.materialTypeId, this.itemsLimit, this.materialType);

  factory HomeType.fromJson(Map<String, dynamic> json) => _$HomeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeTypeToJson(this);
}
