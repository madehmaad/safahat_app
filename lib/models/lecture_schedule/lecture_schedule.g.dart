// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureSchedule _$LectureScheduleFromJson(Map json) => LectureSchedule(
      json['time'],
      json['title'],
      (json['app'] as List<dynamic>?)
          ?.map((e) => App.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['place'],
    );

Map<String, dynamic> _$LectureScheduleToJson(LectureSchedule instance) =>
    <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'place': instance.place,
      'app': instance.app?.map((e) => e.toJson()).toList(),
    };
