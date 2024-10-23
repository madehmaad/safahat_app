// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStream _$LiveStreamFromJson(Map json) => LiveStream(
      mixler: json['mixler'] == null
          ? null
          : LiveStreamForm.fromJson(
              Map<String, dynamic>.from(json['mixler'] as Map)),
      youtube: json['youtube'] == null
          ? null
          : LiveStreamForm.fromJson(
              Map<String, dynamic>.from(json['youtube'] as Map)),
      facebook: json['facebook'] == null
          ? null
          : LiveStreamForm.fromJson(
              Map<String, dynamic>.from(json['facebook'] as Map)),
    );

Map<String, dynamic> _$LiveStreamToJson(LiveStream instance) =>
    <String, dynamic>{
      'youtube': instance.youtube?.toJson(),
      'facebook': instance.facebook?.toJson(),
      'mixler': instance.mixler?.toJson(),
    };
