import 'package:pictures_finder/data/local/local_session_datasource.dart';
import 'package:pictures_finder/data/remote/google_datasource.dart';
import 'package:pictures_finder/model/find_type.dart';
import 'package:pictures_finder/model/provider.dart';
import 'package:pictures_finder/model/sent_session.dart';

class GoogleRepository {
  GoogleRepository({
    required this.googleDatasource,
    required this.localSessionDatasource,
  });

  final GoogleDatasource googleDatasource;
  final LocalSessionDatasource localSessionDatasource;

  Future<int> getFaceSession({
    required String folderUrl,
    required String imagePath,
    String? email,
  }) async {
    final sessionId = await googleDatasource.getFaceResult(
      folderUrl: folderUrl,
      imagePath: imagePath,
      email: email,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        provider: Provider.drive,
        data: imagePath,
        findType: FindType.face,
      ),
    );
    return sessionId;
  }

  Future<int> getBidSession({
    required String folderUrl,
    required String bib,
    String? email,
  }) async {
    final sessionId = await googleDatasource.getBibResult(
      folderUrl: folderUrl,
      bib: bib,
      email: email,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        provider: Provider.drive,
        data: bib,
        findType: FindType.bib,
      ),
    );
    return sessionId;
  }

  Future<int> getClothesSession({
    required String folderUrl,
    required String imagePath,
    String? email,
  }) async {
    final sessionId = await googleDatasource.getClothesResult(
      folderUrl: folderUrl,
      imagePath: imagePath,
      email: email,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        provider: Provider.drive,
        data: imagePath,
        findType: FindType.clothes,
      ),
    );
    return sessionId;
  }
}
