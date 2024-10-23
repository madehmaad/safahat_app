import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  @JsonKey(name: 'questionsHasNextPage')
  bool? questionsHasNextPage;
  List<Category>? list;
  List<Question>? questions;
  int? allTotalCount;

  Search(this.list, this.allTotalCount, this.questions, this.questionsHasNextPage);

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
