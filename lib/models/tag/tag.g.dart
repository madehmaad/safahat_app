// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map json) => Tag(
      id: json['id'] as int?,
      name: json['name'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(Map<String, dynamic>.from(json['pivot'] as Map)),
      color: json['color'],
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'pivot': instance.pivot?.toJson(),
    };
