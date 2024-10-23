// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seriese.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seriese _$SerieseFromJson(Map json) => Seriese(
      json['id'] as int,
      json['title'],
      json['updated_at'],
      json['slug'],
      json['queue'] as int?,
      json['deleted_at'],
      json['created_at'],
      json['active'] as int?,
      json['description'],
      json['main_image'],
      json['main_image_thumbnail'],
      json['is_hidden'] as int?,
      json['pivot'] == null
          ? null
          : Pivot.fromJson(Map<String, dynamic>.from(json['pivot'] as Map)),
    );

Map<String, dynamic> _$SerieseToJson(Seriese instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'queue': instance.queue,
      'active': instance.active,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'main_image': instance.mainImage,
      'main_image_thumbnail': instance.mainImageThumbnail,
      'is_hidden': instance.isHidden,
      'pivot': instance.pivot?.toJson(),
    };
