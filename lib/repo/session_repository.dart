import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/data/local/local_session_datasource.dart';
import 'package:pictures_finder/data/remote/remote_session_datasource.dart';
import 'package:pictures_finder/model/image_result.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/model/session_result.dart';

class SessionRepository {
  SessionRepository({
    required this.localSessionDatasource,
    required this.remoteSessionDatasource,
  });

  final LocalSessionDatasource localSessionDatasource;
  final RemoteSessionDatasource remoteSessionDatasource;

  Future<SessionResult> getSessionResultById({
    required int sessionId,
  }) =>
      remoteSessionDatasource.getSessionResultById(
        sessionId: sessionId,
      );

  Future<List<ImageResult>> getImageResultById({required int sessionId}) =>
      remoteSessionDatasource.getImageResultsById(sessionId: sessionId);

  Iterable<SentSession> getSavedSessions() => localSessionDatasource.datas;

  ValueListenable<Box<SentSession>> getLiveSavedSessions() =>
      localSessionDatasource.getListenable();

  Future<void> deleteSession(int index) =>
      localSessionDatasource.deleteAt(index);
}
