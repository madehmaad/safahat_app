// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCategory _$QuestionCategoryFromJson(Map json) => QuestionCategory(
      id: json['id'],
      title: json['title'],
      updatedAt: json['updated_at'],
      slug: json['slug'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      active: json['active'] as int?,
      mainImage: json['main_image'],
      date: json['date'],
      oldId: json['old_id'],
      parentId: json['parent_id'],
      questionsCount: json['questions_count'] as int?,
      subCategoriesCount: json['sub_categories_count'] as int?,
      questions: json['questions'] == null
          ? null
          : PaginationModel<Question>.fromJson(
              Map<String, dynamic>.from(json['questions'] as Map),
              (value) =>
                  Question.fromJson(Map<String, dynamic>.from(value as Map))),
      subCategories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) =>
              QuestionCategory.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$QuestionCategoryToJson(QuestionCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'old_id': instance.oldId,
      'parent_id': instance.parentId,
      'title': instance.title,
      'slug': instance.slug,
      'active': instance.active,
      'questions_count': instance.questionsCount,
      'sub_categories_count': instance.subCategoriesCount,
      'created_at': instance.createdAt,
      'deleted_at': instance.deletedAt,
      'updated_at': instance.updatedAt,
      'main_image': instance.mainImage,
      'date': instance.date,
      'questions': instance.questions?.toJson(
        (value) => value.toJson(),
      ),
      'sub_categories': instance.subCategories?.map((e) => e.toJson()).toList(),
    };
