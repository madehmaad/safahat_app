// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialModel _$MaterialModelFromJson(Map json) => MaterialModel(
      json['id'] as int,
      json['title'],
      json['created_at'],
      json['description'],
      json['short_description'],
      json['created_by'],
      json['deleted_at'],
      json['featured_video'],
      json['main_image'],
      json['main_image_thumbnail'],
      json['main_video'],
      json['material_date'],
      json['material_type_id'] as int?,
      json['orginal_title'],
      json['publish_date'],
      json['queue'] as int?,
      json['series_id'] as int?,
      json['slug'],
      json['today_views'] as int?,
      json['total_views'] as int?,
      json['updated_at'],
      json['type'] == null
          ? null
          : Category.fromJson(Map<String, dynamic>.from(json['type'] as Map)),
      (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['series'] == null
          ? null
          : Seriese.fromJson(Map<String, dynamic>.from(json['series'] as Map)),
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$MaterialModelToJson(MaterialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'main_image': instance.mainImage,
      'main_video': instance.mainVideo,
      'featured_video': instance.featuredVideo,
      'queue': instance.queue,
      'publish_date': instance.publishDate,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'series_id': instance.seriesId,
      'material_type_id': instance.materialTypeId,
      'total_views': instance.totalViews,
      'today_views': instance.todayViews,
      'material_date': instance.materialDate,
      'created_by': instance.createdBy,
      'orginal_title': instance.orginalTitle,
      'main_image_thumbnail': instance.mainImageThumbnail,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'topics': instance.topics?.map((e) => e.toJson()).toList(),
      'series': instance.series?.toJson(),
      'type': instance.type?.toJson(),
    };
