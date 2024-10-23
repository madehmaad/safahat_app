import 'package:isar/isar.dart';

part 'favorite_collection.g.dart';

@collection
class Favorite {
  Id id = Isar.autoIncrement;
  // @Index(unique: true, replace: true)
  // String key = DateTime.now().toIso8601String();
  late String title;
  late bool isRoot;
  late bool isFolder;
  String? imageUrl;
  String? slug;
  IsarLinks<Favorite> children = IsarLinks<Favorite>();
}
