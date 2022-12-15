import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/model/find_type.dart';
import 'package:pictures_finder/model/provider.dart';

part 'sent_session.g.dart';

@HiveType(typeId: 1)
class SentSession {
  const SentSession({
    required this.sessionId,
    required this.provider,
    required this.data,
    required this.createdAt,
    required this.findType,
  });

  @HiveField(0)
  final int sessionId;

  @HiveField(1)
  final Provider provider;

  @HiveField(2)
  final String data;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final FindType findType;
}
