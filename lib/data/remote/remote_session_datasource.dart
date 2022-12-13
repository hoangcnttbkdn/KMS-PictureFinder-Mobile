import 'package:pictures_finder/data/http_handler.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/model/session_result.dart';

class RemoteSessionDatasource {
  RemoteSessionDatasource({
    required this.httpClientHandler,
  });
  final HttpClientHandler httpClientHandler;

  Future<List<ImageResult>> getImageResultsById({
    required int sessionId,
  }) async {
    try {
      final response =
          await httpClientHandler.get(getImageResultById(sessionId)) as List;
      if (response.isEmpty) return [];
      return response
          .map((data) => ImageResult.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SessionResult> getSessionResultById({
    required int sessionId,
  }) async {
    try {
      final response = await httpClientHandler.get(getSessionResult(sessionId));
      return SessionResult.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}

String getImageResultById(int id) => '/api/sessions/$id/images';

String getSessionResult(int id) => '/api/sessions/$id';
