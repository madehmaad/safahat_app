// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pages_app/core/domain/model/Model.dart';

class TeacherModel extends Model {
  String id;
  String password;
  String name;
  String JobType;
  bool isBlocked;
  TeacherModel({
    required this.id,
    required this.password,
    required this.name,
    required this.JobType,
    required this.isBlocked,
  });

  TeacherModel copyWith({
    String? id,
    String? password,
    String? name,
    String? JobType,
    bool? isBlocked,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      JobType: JobType ?? this.JobType,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'password': password,
      'name': name,
      'JobType': JobType,
      'isBlocked': isBlocked,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['id'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      JobType: map['JobType'] as String,
      isBlocked: map['isBlocked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherModel(id: $id, password: $password, name: $name, JobType: $JobType, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.password == password &&
        other.name == name &&
        other.JobType == JobType &&
        other.isBlocked == isBlocked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        password.hashCode ^
        name.hashCode ^
        JobType.hashCode ^
        isBlocked.hashCode;
  }
}
