import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/data/local/local_session_datasource.dart';
import 'package:pictures_finder/data/remote/facebook_datasource.dart';
import 'package:pictures_finder/data/remote/google_datasource.dart';
import 'package:pictures_finder/data/remote/remote_session_datasource.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/model/provider.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/model/session_result.dart';

class ImageRepository {
  ImageRepository({
    required this.googleDatasource,
    required this.facebookDatasource,
    required this.localSessionDatasource,
    required this.remoteSessionDatasource,
  });

  final GoogleDatasource googleDatasource;
  final FacebookDatasource facebookDatasource;
  final LocalSessionDatasource localSessionDatasource;
  final RemoteSessionDatasource remoteSessionDatasource;

  Future<int> getSessionFromGoogle({
    required String folderUrl,
    required String imagePath,
  }) async {
    final sessionId = await googleDatasource.getResult(
      folderUrl: folderUrl,
      imagePath: imagePath,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        type: Provider.drive,
        imagePath: imagePath,
      ),
    );
    return sessionId;
  }

  Future<int> getImageResultsBySessionId({
    required String folderUrl,
    required String imagePath,
  }) async {
    final sessionId = await googleDatasource.getResult(
      folderUrl: folderUrl,
      imagePath: imagePath,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        type: Provider.drive,
        imagePath: imagePath,
      ),
    );
    return sessionId;
  }

  Future<SessionResult> getSessionResultById({
    required int sessionId,
  }) =>
      remoteSessionDatasource.getSessionResultById(
        sessionId: sessionId,
      );

  //58 //50 //56 57

  Future<List<ImageResult>> getImageResultById({required int sessionId}) =>
      remoteSessionDatasource.getImageResultsById(sessionId: sessionId);

  Future<int> getSessionFromFacebook({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    final sessionId = await facebookDatasource.getResult(
      accessToken: accessToken,
      cookie: cookie,
      albumUrl: albumUrl,
      imagePath: imagePath,
      email: email,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        type: Provider.facebook,
        imagePath: imagePath,
      ),
    );
    return sessionId;
  }

  Iterable<SentSession> getSavedSessions() => localSessionDatasource.datas;

  ValueListenable<Box<SentSession>> getLiveSavedSessions() =>
      localSessionDatasource.getListenable();

  Future<void> deleteSession(int index) =>
      localSessionDatasource.deleteAt(index);
}
