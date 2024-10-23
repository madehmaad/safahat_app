// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map json) => Category(
      id: json['id'],
      title: json['title'],
      updatedAt: json['updated_at'],
      slug: json['slug'],
      queue: json['queue'] as int?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      active: json['active'] as int?,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) =>
              MaterialModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      priority: json['priority'] as int?,
      hasNextPage: json['hasNextPage'] as bool?,
      serieses: (json['serieses'] as List<dynamic>?)
          ?.map((e) => Seriese.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'queue': instance.queue,
      'active': instance.active,
      'priority': instance.priority,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'materials': instance.materials?.map((e) => e.toJson()).toList(),
      'serieses': instance.serieses?.map((e) => e.toJson()).toList(),
      'hasNextPage': instance.hasNextPage,
    };
