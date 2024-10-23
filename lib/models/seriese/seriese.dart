import 'package:dr_alshaal/models/pivot/pivot.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seriese.g.dart';

@JsonSerializable()
class Seriese {
  int id;
  dynamic title;
  dynamic slug;
  dynamic description;
  int? queue;
  int? active;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic mainImage;
  dynamic mainImageThumbnail;
  int? isHidden;
  Pivot? pivot;

  Seriese(this.id, this.title, this.updatedAt, this.slug, this.queue, this.deletedAt, this.createdAt, this.active,
      this.description, this.mainImage, this.mainImageThumbnail, this.isHidden, this.pivot);

  factory Seriese.fromJson(Map<String, dynamic> json) => _$SerieseFromJson(json);

  Map<String, dynamic> toJson() => _$SerieseToJson(this);
}
