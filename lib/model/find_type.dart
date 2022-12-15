import 'package:hive_flutter/hive_flutter.dart';

part 'find_type.g.dart';

@HiveType(typeId: 3)
enum FindType {
  @HiveField(0)
  face,

  @HiveField(1)
  bib,

  @HiveField(2)
  clothes,
}
