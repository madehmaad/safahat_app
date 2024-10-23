import 'package:json_annotation/json_annotation.dart';

import '../pivot/pivot.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  int? id;
  dynamic name;
  dynamic color;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Tag({this.id, this.name, this.updatedAt, this.createdAt, this.deletedAt, this.pivot, this.color});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
