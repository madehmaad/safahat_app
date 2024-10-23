import 'package:dr_alshaal/models/material/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../seriese/seriese.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  dynamic id;
  dynamic title;
  dynamic slug;
  int? queue;
  int? active;
  int? priority;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  List<MaterialModel>? materials;
  List<Seriese>? serieses;
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;

  Category(
      {this.id,
      this.title,
      this.updatedAt,
      this.slug,
      this.queue,
      this.deletedAt,
      this.createdAt,
      this.active,
      this.materials,
      this.priority,
      this.hasNextPage,
      this.serieses});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
