// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pivot _$PivotFromJson(Map json) => Pivot(
      json['material_type_id'] as int?,
      json['series_id'] as int?,
      json['material_id'] as int?,
      json['tag_id'] as int?,
      json['topic_id'] as int?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'material_type_id': instance.materialTypeId,
      'material_id': instance.materialId,
      'topic_id': instance.topicId,
      'series_id': instance.seriesId,
      'tag_id': instance.tagId,
    };
