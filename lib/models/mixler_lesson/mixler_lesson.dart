import 'package:json_annotation/json_annotation.dart';

part 'mixler_lesson.g.dart';

@JsonSerializable()
class MixlerLesson {
  int id;
  dynamic name;
  dynamic time;
  int queue;
  dynamic firstRepeat;
  dynamic secondRepeat;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  MixlerLesson(this.id, this.queue, this.createdAt, this.name, this.deletedAt, this.updatedAt, this.time,
      this.firstRepeat, this.secondRepeat);

  factory MixlerLesson.fromJson(Map<String, dynamic> json) => _$MixlerLessonFromJson(json);

  Map<String, dynamic> toJson() => _$MixlerLessonToJson(this);
}
