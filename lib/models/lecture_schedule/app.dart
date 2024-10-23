import 'package:json_annotation/json_annotation.dart';

part 'app.g.dart';

@JsonSerializable()
class App {
  dynamic logo;
  dynamic name;
  dynamic link;

  App(this.link, this.name, this.logo);

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

  Map<String, dynamic> toJson() => _$AppToJson(this);
}
