import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/model/provider.dart';

part 'sent_session.g.dart';

@HiveType(typeId: 1)
class SentSession {
  const SentSession({
    required this.sessionId,
    required this.type,
    required this.createdAt,
    required this.imagePath,
  });

  @HiveField(0)
  final int sessionId;

  @HiveField(1)
  final Provider type;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final DateTime createdAt;
}
