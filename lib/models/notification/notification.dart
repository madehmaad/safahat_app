import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel {
  dynamic id;
  dynamic title;
  dynamic body;
  dynamic shortBody;
  dynamic image;
  dynamic imageThumbnail;
  dynamic createdAt;
  dynamic createdDate;

  NotificationModel(this.id, this.createdAt, this.title, this.body, this.image, this.createdDate, this.imageThumbnail,
      this.shortBody);

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
