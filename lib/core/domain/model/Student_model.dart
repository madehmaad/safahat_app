// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pages_app/core/domain/model/Model.dart';

class StudentModel extends Model {
  String id;
  String name;
  int password;
  String group;

  StudentModel({
    required this.id,
    required this.name,
    required this.password,
    required this.group,
  });

  StudentModel copyWith({
    String? id,
    String? name,
    int? password,
    String? group,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'group': group,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      password: map['password'] as int,
      group: map['group'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModel(id: $id, name: $name, password: $password, group: $group)';
  }

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.password == password &&
        other.group == group;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ password.hashCode ^ group.hashCode;
  }
}
