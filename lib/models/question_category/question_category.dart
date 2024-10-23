import 'package:json_annotation/json_annotation.dart';

import '../pagination_model/pagination_model.dart';
import '../question/question.dart';

part 'question_category.g.dart';

@JsonSerializable()
class QuestionCategory {
  dynamic id;
  dynamic oldId;
  dynamic parentId;
  dynamic title;
  dynamic slug;
  int? active;
  int? questionsCount;
  int? subCategoriesCount;
  dynamic createdAt;
  dynamic deletedAt;
  dynamic updatedAt;
  dynamic mainImage;
  dynamic date;
  PaginationModel<Question>? questions;
  List<QuestionCategory>? subCategories;

  QuestionCategory(
      {this.id,
      this.title,
      this.updatedAt,
      this.slug,
      this.deletedAt,
      this.createdAt,
      this.active,
      this.mainImage,
      this.date,
      this.oldId,
      this.parentId,
      this.questionsCount,
      this.subCategoriesCount,
      this.questions,
      this.subCategories});

  factory QuestionCategory.fromJson(Map<String, dynamic> json) => _$QuestionCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCategoryToJson(this);
}
