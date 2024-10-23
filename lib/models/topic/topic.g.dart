// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map json) => Topic(
      id: json['id'] as int?,
      title: json['title'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      icone: json['icone'],
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(Map<String, dynamic>.from(json['pivot'] as Map)),
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icone': instance.icone,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot?.toJson(),
    };
