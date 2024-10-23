import 'package:isar/isar.dart';

part 'download_collection.g.dart';

@collection
class Download {
  Id id = Isar.autoIncrement;
  late String name;
  late String filePath;
  late String slug;
  String? url;
  int? size;
  String? materialTitle;
  String? imageUrl;
  String? prefix;
  String? taskId;
  String? downloadAt;
}
