// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeType _$HomeTypeFromJson(Map json) => HomeType(
      json['id'] as int?,
      json['title'],
      json['updated_at'],
      json['created_at'],
      json['material_type_id'] as int?,
      json['items_limit'] as int?,
      json['material_type'] == null
          ? null
          : Category.fromJson(
              Map<String, dynamic>.from(json['material_type'] as Map)),
    );

Map<String, dynamic> _$HomeTypeToJson(HomeType instance) => <String, dynamic>{
      'id': instance.id,
      'items_limit': instance.itemsLimit,
      'material_type_id': instance.materialTypeId,
      'title': instance.title,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'material_type': instance.materialType?.toJson(),
    };
