// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_result_extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResultExtraData _$ImageResultExtraDataFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ImageResultExtraData',
      json,
      ($checkedConvert) {
        final val = ImageResultExtraData(
          numberOfFace: $checkedConvert('numberOfFace', (v) => v as int?),
          faceLocation: $checkedConvert('faceLocation',
              (v) => (v as List<dynamic>?)?.map((e) => e as int).toList()),
          confident: $checkedConvert('confident', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );
