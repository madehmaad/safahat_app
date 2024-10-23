import 'package:dr_alshaal/models/category/category.dart';
import 'package:dr_alshaal/models/topic/topic.dart';
import 'package:json_annotation/json_annotation.dart';

import '../attachment/attachment.dart';
import '../seriese/seriese.dart';
import '../tag/tag.dart';

part 'material.g.dart';

@JsonSerializable()
class MaterialModel {
  int id;
  dynamic title;
  dynamic slug;
  dynamic shortDescription;
  dynamic description;
  dynamic mainImage;
  dynamic mainVideo;
  dynamic featuredVideo;
  int? queue;
  dynamic publishDate;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  int? seriesId;
  int? materialTypeId;
  int? totalViews;
  int? todayViews;
  dynamic materialDate;
  dynamic createdBy;
  dynamic orginalTitle;
  dynamic mainImageThumbnail;
  List<Tag>? tags;
  List<Attachment>? attachments;
  List<Topic>? topics;
  Seriese? series;
  Category? type;

  MaterialModel(
      this.id,
      this.title,
      this.createdAt,
      this.description,
      this.shortDescription,
      this.createdBy,
      this.deletedAt,
      this.featuredVideo,
      this.mainImage,
      this.mainImageThumbnail,
      this.mainVideo,
      this.materialDate,
      this.materialTypeId,
      this.orginalTitle,
      this.publishDate,
      this.queue,
      this.seriesId,
      this.slug,
      this.todayViews,
      this.totalViews,
      this.updatedAt,
      this.type,
      this.topics,
      this.series,
      this.attachments,
      this.tags);

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);
}
