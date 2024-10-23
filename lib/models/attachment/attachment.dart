import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable()
class Attachment {
  int? id;
  dynamic path;
  dynamic type;
  int? size;
  int? attachedToId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic title;
  dynamic duration;
  int? playable;
  int? addedBy;

  Attachment(
      {this.id,
      this.type,
      this.updatedAt,
      this.createdAt,
      this.deletedAt,
      this.size,
      this.title,
      this.path,
      this.addedBy,
      this.attachedToId,
      this.duration,
      this.playable});

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
