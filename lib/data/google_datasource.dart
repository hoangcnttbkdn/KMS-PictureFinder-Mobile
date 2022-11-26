import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pictures_finder/data/http_handler.dart';
import 'package:pictures_finder/model/image_result.dart';

class GoogleDatasource {
  GoogleDatasource(this.httpHandler);

  final HttpClientHandler httpHandler;

  Future<List<ImageResult>> getListResult({
    required String folderUrl,
    required String imagePath,
  }) async {
    try {
      var formData = FormData.fromMap({
        'folderUrl': folderUrl,
        'targetImage': await MultipartFile.fromFile(imagePath),
      });
      final repsonseBody = await httpHandler.postFile(
        '/api/gg-drive',
        formData: formData,
      );
      final list = repsonseBody as List;
      return list
          .map((e) => ImageResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }
}
