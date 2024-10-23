import 'package:dr_alshaal/models/lecture_schedule/app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lecture_schedule.g.dart';

@JsonSerializable()
class LectureSchedule {
  dynamic title;
  dynamic time;
  dynamic place;
  List<App>? app;

  LectureSchedule(this.time, this.title, this.app, this.place);

  factory LectureSchedule.fromJson(Map<String, dynamic> json) => _$LectureScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$LectureScheduleToJson(this);
}
