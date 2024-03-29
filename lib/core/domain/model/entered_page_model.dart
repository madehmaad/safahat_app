// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pages_app/core/domain/model/Model.dart';

class enteredPage extends Model {
  String full_name;
  int page_no;
  String listen_date;
  String listener_name;
  String Courses_Name;
  enteredPage({
    required this.full_name,
    required this.page_no,
    required this.listen_date,
    required this.listener_name,
    required this.Courses_Name,
  });

  enteredPage copyWith({
    String? full_name,
    int? page_no,
    String? listen_date,
    String? listener_name,
    String? Courses_Name,
  }) {
    return enteredPage(
      full_name: full_name ?? this.full_name,
      page_no: page_no ?? this.page_no,
      listen_date: listen_date ?? this.listen_date,
      listener_name: listener_name ?? this.listener_name,
      Courses_Name: Courses_Name ?? this.Courses_Name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': full_name,
      'page_no': page_no,
      'listen_date': listen_date,
      'listener_name': listener_name,
      'Courses_Name': Courses_Name,
    };
  }

  factory enteredPage.fromMap(Map<String, dynamic> map) {
    return enteredPage(
      full_name: map['full_name'] as String,
      page_no: map['page_no'] as int,
      listen_date: map['listen_date'] as String,
      listener_name: map['listener_name'] as String,
      Courses_Name: map['Courses_Name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory enteredPage.fromJson(String source) => enteredPage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'enteredPage(full_name: $full_name, page_no: $page_no, listen_date: $listen_date, listener_name: $listener_name, Courses_Name: $Courses_Name)';
  }

  @override
  bool operator ==(covariant enteredPage other) {
    if (identical(this, other)) return true;
  
    return 
      other.full_name == full_name &&
      other.page_no == page_no &&
      other.listen_date == listen_date &&
      other.listener_name == listener_name &&
      other.Courses_Name == Courses_Name;
  }

  @override
  int get hashCode {
    return full_name.hashCode ^
      page_no.hashCode ^
      listen_date.hashCode ^
      listener_name.hashCode ^
      Courses_Name.hashCode;
  }
}
