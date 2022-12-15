import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:pictures_finder/data/http_handler.dart';

class GoogleDatasource {
  GoogleDatasource(this.httpHandler);

  final HttpClientHandler httpHandler;

  Future<int> getFaceResult({
    required String folderUrl,
    required String imagePath,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.postFile(
        '/api/gg-drive/face',
        fields: email == null
            ? {
                'folderUrl': folderUrl,
              }
            : {
                'folderUrl': folderUrl,
                'email': email,
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
      final sessionId = (repsonseBody as Map<String, dynamic>)['sessionId'];
      return sessionId;
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  Future<int> getBibResult({
    required String folderUrl,
    required String bib,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.post(
        '/api/gg-drive/bib',
        body: email == null
            ? {
                'folderUrl': folderUrl,
                'bib': bib,
              }
            : {
                'folderUrl': folderUrl,
                'bib': bib,
                'email': email,
              },
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.value
        },
      );
      final sessionId = (repsonseBody as Map<String, dynamic>)['sessionId'];
      return sessionId;
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  Future<int> getClothesResult({
    required String folderUrl,
    required String imagePath,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.postFile(
        '/api/gg-drive/clothes',
        fields: email == null
            ? {
                'folderUrl': folderUrl,
              }
            : {
                'folderUrl': folderUrl,
                'email': email,
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
      final sessionId = (repsonseBody as Map<String, dynamic>)['sessionId'];
      return sessionId;
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }
}
