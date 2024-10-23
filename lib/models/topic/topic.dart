import 'package:json_annotation/json_annotation.dart';

import '../pivot/pivot.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  int? id;
  dynamic title;
  dynamic icone;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Topic({this.id, this.title, this.updatedAt, this.createdAt, this.icone, this.pivot});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
