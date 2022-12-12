import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
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
      final repsonseBody = await httpHandler.postFile(
        '/api/gg-drive',
        fields: {
          'folderUrl': folderUrl,
        },
        multipartFile: await http.MultipartFile.fromPath(
          'targetImage',
          imagePath,
          contentType: MediaType('image', p.extension(imagePath).split('.')[1]),
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data'
        },
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
