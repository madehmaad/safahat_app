import 'package:json_annotation/json_annotation.dart';

part 'pivot.g.dart';

@JsonSerializable()
class Pivot {
  int? materialTypeId;
  int? materialId;
  int? topicId;
  int? seriesId;
  int? tagId;

  Pivot(this.materialTypeId, this.seriesId, this.materialId, this.tagId, this.topicId);

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}
