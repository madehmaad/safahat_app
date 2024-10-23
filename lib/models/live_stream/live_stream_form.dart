import 'package:json_annotation/json_annotation.dart';

part 'live_stream_form.g.dart';

@JsonSerializable()
class LiveStreamForm {
  dynamic iframLink;
  dynamic redirectLink;

  LiveStreamForm({this.iframLink, this.redirectLink});

  factory LiveStreamForm.fromJson(Map<String, dynamic> json) => _$LiveStreamFormFromJson(json);

  Map<String, dynamic> toJson() => _$LiveStreamFormToJson(this);
}
