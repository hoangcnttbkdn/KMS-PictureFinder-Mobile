// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResult _$SessionResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SessionResult',
      json,
      ($checkedConvert) {
        final val = SessionResult(
          id: $checkedConvert('id', (v) => v as int),
          url: $checkedConvert('url', (v) => v as String),
          targetImageUrl: $checkedConvert('targetImageUrl', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String?),
          totalImages: $checkedConvert('totalImages', (v) => v as int),
          type:
              $checkedConvert('type', (v) => $enumDecode(_$ProviderEnumMap, v)),
          isFinished: $checkedConvert('isFinished', (v) => v as bool),
          createdAt: $checkedConvert(
              'createdAt', (v) => SessionResult._fromJson(v as String)),
          updatedAt: $checkedConvert(
              'updatedAt', (v) => SessionResult._fromJson(v as String)),
        );
        return val;
      },
    );

const _$ProviderEnumMap = {
  Provider.drive: 'DRIVE',
  Provider.facebook: 'FACEBOOK',
};
