import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pictures_finder/model/provider.dart';

part 'session_result.g.dart';

@JsonSerializable(createToJson: false, checked: true)
class SessionResult {
  SessionResult({
    required this.id,
    required this.url,
    required this.targetImageUrl,
    this.email,
    required this.totalImages,
    required this.type,
    required this.isFinished,
    required this.createdAt,
    required this.updatedAt,
  });
  factory SessionResult.fromJson(Map<String, dynamic> json) =>
      _$SessionResultFromJson(json);

  final int id;
  final String url;
  final String targetImageUrl;
  final String? email;
  final int totalImages;
  final Provider type;
  final bool isFinished;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromJson)
  final DateTime updatedAt;

  static DateTime _fromJson(String data) =>
      DateFormat('yyyy-MM-ddTHH:MM:ss').parse(data, true);
}
