import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pictures_finder/model/image_result_extra_data.dart';

part 'image_result.g.dart';

@JsonSerializable(createToJson: false, checked: true)
class ImageResult {
  ImageResult({
    required this.id,
    required this.code,
    required this.url,
    required this.isMatched,
    required this.recognizedAt,
    required this.extraData,
    this.errorLogs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageResult.fromJson(Map<String, dynamic> json) =>
      _$ImageResultFromJson(json);

  final int id;
  final String code;

  final String url;
  final bool isMatched;
  final DateTime recognizedAt;
  @JsonKey(fromJson: _extraDatafromJson)
  final ImageResultExtraData extraData;
  final String? errorLogs;
  @JsonKey(fromJson: _fromJson)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromJson)
  final DateTime updatedAt;

  static DateTime _fromJson(String data) =>
      DateFormat('yyyy-MM-ddTHH:MM:ss').parse(data, true);

  static ImageResultExtraData _extraDatafromJson(String data) =>
      ImageResultExtraData.fromJson(jsonDecode(data) as Map<String, dynamic>);
}
