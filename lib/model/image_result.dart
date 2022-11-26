
import 'package:json_annotation/json_annotation.dart';

part 'image_result.g.dart';

@JsonSerializable(createToJson: false)
class ImageResult {
  ImageResult({required this.id, required this.url});

  factory ImageResult.fromJson(Map<String, dynamic> json) =>
      _$ImageResultFromJson(json);

  final String id;
  final String url;
}
