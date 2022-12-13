import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'provider.g.dart';

@HiveType(typeId: 2)
enum Provider {
  @HiveField(0)
  @JsonValue('DRIVE')
  drive,

  @HiveField(1)
  @JsonValue('FACEBOOK')
  facebook
}
