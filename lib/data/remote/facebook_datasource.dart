import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:pictures_finder/data/http_handler.dart';

class FacebookDatasource {
  FacebookDatasource(this.httpHandler);

  final HttpClientHandler httpHandler;

  Future<int> getFaceResult({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.postFile(
        '/api/facebook/face',
        fields: email == null
            ? {
                'accessToken': accessToken,
                'cookie': cookie,
                'albumUrl': albumUrl,
              }
            : {
                'accessToken': accessToken,
                'cookie': cookie,
                'albumUrl': albumUrl,
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
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String bib,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.post(
        '/api/facebook/bib',
        body: email == null
            ? {
                'accessToken': accessToken,
                'cookie': cookie,
                'bib': bib,
                'albumUrl': albumUrl,
              }
            : {
                'accessToken': accessToken,
                'cookie': cookie,
                'bib': bib,
                'albumUrl': albumUrl,
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
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.postFile(
        '/api/facebook/clothes',
        fields: email == null
            ? {
                'accessToken': accessToken,
                'cookie': cookie,
                'albumUrl': albumUrl,
              }
            : {
                'accessToken': accessToken,
                'cookie': cookie,
                'albumUrl': albumUrl,
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
