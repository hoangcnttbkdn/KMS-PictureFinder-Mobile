import 'package:pictures_finder/data/local/local_session_datasource.dart';
import 'package:pictures_finder/data/remote/facebook_datasource.dart';
import 'package:pictures_finder/model/find_type.dart';
import 'package:pictures_finder/model/provider.dart';
import 'package:pictures_finder/model/sent_session.dart';

class FacebookRepository {
  FacebookRepository({
    required this.facebookDatasource,
    required this.localSessionDatasource,
  });

  final FacebookDatasource facebookDatasource;
  final LocalSessionDatasource localSessionDatasource;

  Future<int> createFaceSession({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    final sessionId = await facebookDatasource.getFaceResult(
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
        provider: Provider.facebook,
        data: imagePath,
        findType: FindType.face,
      ),
    );
    return sessionId;
  }

  Future<int> createBidSession({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String bib,
    String? email,
  }) async {
    final sessionId = await facebookDatasource.getBibResult(
      accessToken: accessToken,
      cookie: cookie,
      albumUrl: albumUrl,
      bib: bib,
      email: email,
    );
    await localSessionDatasource.insert(
      SentSession(
        sessionId: sessionId,
        createdAt: DateTime.now(),
        provider: Provider.facebook,
        data: bib,
        findType: FindType.bib,
      ),
    );
    return sessionId;
  }

  Future<int> createClothesSession({
    required String accessToken,
    required String cookie,
    required String albumUrl,
    required String imagePath,
    String? email,
  }) async {
    final sessionId = await facebookDatasource.getClothesResult(
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
        provider: Provider.facebook,
        data: imagePath,
        findType: FindType.clothes,
      ),
    );
    return sessionId;
  }
}
