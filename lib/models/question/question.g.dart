// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map json) => Question(
      id: json['id'] as int?,
      title: json['title'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      publishDate: json['publish_date'],
      name: json['name'],
      address: json['address'],
      date: json['date'],
      phone: json['phone'],
      description: json['description'],
      categoryId: json['category_id'] as int?,
      gender: json['gender'],
      email: json['email'],
      age: json['age'] as int?,
      answer: json['answer'],
      assignedTo: json['assigned_to'],
      countryId: json['country_id'],
      isPrivate: json['is_private'] as int?,
      job: json['job'],
      statusId: json['status_id'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'email': instance.email,
      'answer': instance.answer,
      'date': instance.date,
      'publish_date': instance.publishDate,
      'status_id': instance.statusId,
      'category_id': instance.categoryId,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
      'phone': instance.phone,
      'job': instance.job,
      'address': instance.address,
      'age': instance.age,
      'is_private': instance.isPrivate,
      'gender': instance.gender,
      'country_id': instance.countryId,
      'assigned_to': instance.assignedTo,
    };
