// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map json) => Search(
      (json['list'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['all_total_count'] as int?,
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['questionsHasNextPage'] as bool?,
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'questionsHasNextPage': instance.questionsHasNextPage,
      'list': instance.list?.map((e) => e.toJson()).toList(),
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
      'all_total_count': instance.allTotalCount,
    };
