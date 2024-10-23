// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mixler_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixlerLesson _$MixlerLessonFromJson(Map json) => MixlerLesson(
      json['id'] as int,
      json['queue'] as int,
      json['created_at'],
      json['name'],
      json['deleted_at'],
      json['updated_at'],
      json['time'],
      json['first_repeat'],
      json['second_repeat'],
    );

Map<String, dynamic> _$MixlerLessonToJson(MixlerLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'queue': instance.queue,
      'first_repeat': instance.firstRepeat,
      'second_repeat': instance.secondRepeat,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
