// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map json) => NotificationModel(
      json['id'],
      json['created_at'],
      json['title'],
      json['body'],
      json['image'],
      json['created_date'],
      json['image_thumbnail'],
      json['short_body'],
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'short_body': instance.shortBody,
      'image': instance.image,
      'image_thumbnail': instance.imageThumbnail,
      'created_at': instance.createdAt,
      'created_date': instance.createdDate,
    };
