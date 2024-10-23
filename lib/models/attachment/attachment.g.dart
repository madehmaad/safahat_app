// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map json) => Attachment(
      id: json['id'] as int?,
      type: json['type'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      size: json['size'] as int?,
      title: json['title'],
      path: json['path'],
      addedBy: json['added_by'] as int?,
      attachedToId: json['attached_to_id'] as int?,
      duration: json['duration'],
      playable: json['playable'] as int?,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'type': instance.type,
      'size': instance.size,
      'attached_to_id': instance.attachedToId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'title': instance.title,
      'duration': instance.duration,
      'playable': instance.playable,
      'added_by': instance.addedBy,
    };
