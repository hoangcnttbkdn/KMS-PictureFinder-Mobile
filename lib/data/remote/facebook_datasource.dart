import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:pictures_finder/data/http_handler.dart';

class FacebookDatasource {
  FacebookDatasource(this.httpHandler);

  final HttpClientHandler httpHandler;

  Future<int> getResult({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    try {
      final repsonseBody = await httpHandler.postFile(
        '/api/facebook',
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
