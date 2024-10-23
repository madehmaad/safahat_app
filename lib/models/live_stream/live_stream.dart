import 'package:json_annotation/json_annotation.dart';

import 'live_stream_form.dart';

part 'live_stream.g.dart';

@JsonSerializable()
class LiveStream {
  LiveStreamForm? youtube;
  LiveStreamForm? facebook;
  LiveStreamForm? mixler;

  LiveStream({this.mixler, this.youtube, this.facebook});

  factory LiveStream.fromJson(Map<String, dynamic> json) => _$LiveStreamFromJson(json);

  Map<String, dynamic> toJson() => _$LiveStreamToJson(this);
}
