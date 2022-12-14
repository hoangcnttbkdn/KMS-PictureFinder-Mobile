// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResult _$ImageResultFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ImageResult',
      json,
      ($checkedConvert) {
        final val = ImageResult(
          id: $checkedConvert('id', (v) => v as int),
          code: $checkedConvert('code', (v) => v as String),
          url: $checkedConvert('url', (v) => v as String),
          isMatched: $checkedConvert('isMatched', (v) => v as bool),
          recognizedAt: $checkedConvert(
              'recognizedAt', (v) => DateTime.parse(v as String)),
          extraData: $checkedConvert(
              'extraData', (v) => ImageResult._extraDatafromJson(v as String)),
          errorLogs: $checkedConvert('errorLogs', (v) => v as String?),
          createdAt: $checkedConvert(
              'createdAt', (v) => ImageResult._fromJson(v as String)),
          updatedAt: $checkedConvert(
              'updatedAt', (v) => ImageResult._fromJson(v as String)),
        );
        return val;
      },
    );
