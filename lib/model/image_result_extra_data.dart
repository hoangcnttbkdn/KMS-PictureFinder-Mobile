import 'package:json_annotation/json_annotation.dart';

part 'image_result_extra_data.g.dart';

@JsonSerializable(createToJson: false, checked: true)
class ImageResultExtraData {
  ImageResultExtraData({
    required this.numberOfFace,
    required this.faceLocation,
    required this.confident,
  });

  factory ImageResultExtraData.fromJson(Map<String, dynamic> json) =>
      _$ImageResultExtraDataFromJson(json);

  final int numberOfFace;
  final List<int> faceLocation;
  final double confident;
}
