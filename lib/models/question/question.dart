import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  int? id;
  dynamic title;
  dynamic description;
  dynamic email;
  dynamic answer;
  dynamic date;
  dynamic publishDate;
  int? statusId;
  int? categoryId;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic phone;
  dynamic job;
  dynamic address;
  int? age;
  int? isPrivate;
  dynamic gender;
  dynamic countryId;
  dynamic assignedTo;

  Question({
    this.id,
    this.title,
    this.updatedAt,
    this.deletedAt,
    this.createdAt,
    this.publishDate,
    this.name,
    this.address,
    this.date,
    this.phone,
    this.description,
    this.categoryId,
    this.gender,
    this.email,
    this.age,
    this.answer,
    this.assignedTo,
    this.countryId,
    this.isPrivate,
    this.job,
    this.statusId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
