// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_type_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTypeMaterial _$HomeTypeMaterialFromJson(Map json) => HomeTypeMaterial(
      json['type'] == null
          ? null
          : HomeType.fromJson(Map<String, dynamic>.from(json['type'] as Map)),
      json['materials'] == null
          ? null
          : PaginationModel<MaterialModel>.fromJson(
              Map<String, dynamic>.from(json['materials'] as Map),
              (value) => MaterialModel.fromJson(
                  Map<String, dynamic>.from(value as Map))),
    );

Map<String, dynamic> _$HomeTypeMaterialToJson(HomeTypeMaterial instance) =>
    <String, dynamic>{
      'type': instance.type?.toJson(),
      'materials': instance.materials?.toJson(
        (value) => value.toJson(),
      ),
    };
