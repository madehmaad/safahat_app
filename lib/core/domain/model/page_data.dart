// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pages_app/core/domain/model/Model.dart';

class PageDataModel extends Model {
  String full_name;
  int page;
  String listen_date;
  String listener_name;
  PageDataModel({
    required this.full_name,
    required this.page,
    required this.listen_date,
    required this.listener_name,
  });

  PageDataModel copyWith({
    String? full_name,
    int? page,
    String? listen_date,
    String? listener_name,
  }) {
    return PageDataModel(
      full_name: full_name ?? this.full_name,
      page: page ?? this.page,
      listen_date: listen_date ?? this.listen_date,
      listener_name: listener_name ?? this.listener_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': full_name,
      'page': page,
      'listen_date': listen_date,
      'listener_name': listener_name,
    };
  }

  factory PageDataModel.fromMap(Map<String, dynamic> map) {
    return PageDataModel(
      full_name: map['full_name'] as String,
      page: map['page'] as int,
      listen_date: map['listen_date'] as String,
      listener_name: map['listener_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PageDataModel.fromJson(String source) => PageDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PageDataModel(full_name: $full_name, page: $page, listen_date: $listen_date, listener_name: $listener_name)';
  }

  @override
  bool operator ==(covariant PageDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.full_name == full_name &&
      other.page == page &&
      other.listen_date == listen_date &&
      other.listener_name == listener_name;
  }

  @override
  int get hashCode {
    return full_name.hashCode ^
      page.hashCode ^
      listen_date.hashCode ^
      listener_name.hashCode;
  }
}
