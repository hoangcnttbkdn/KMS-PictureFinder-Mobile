import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:pictures_finder/app.dart';
import 'package:pictures_finder/data/http_handler.dart';
import 'package:pictures_finder/data/local/local_session_datasource.dart';
import 'package:pictures_finder/data/remote/facebook_datasource.dart';
import 'package:pictures_finder/data/remote/google_datasource.dart';
import 'package:pictures_finder/data/remote/remote_session_datasource.dart';
import 'package:pictures_finder/model/find_type.dart';
import 'package:pictures_finder/model/provider.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/facebook_repository.dart';
import 'package:pictures_finder/repo/google_repository.dart';
import 'package:pictures_finder/repo/session_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

const baseUri = 'http://be.picturesfinder.software';

Future<void> main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ProviderAdapter())
    ..registerAdapter(SentSessionAdapter())
    ..registerAdapter(FindTypeAdapter());
  initializeDateFormatting();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  final box = await Hive.openBox<SentSession>('session');
  final httpHandler = HttpClientHandler(httpClient: http.Client());
  final googleDatasource = GoogleDatasource(httpHandler);
  final facebookDatasource = FacebookDatasource(httpHandler);
  final sessionDatasource = LocalSessionDatasource(box: box);
  final remoteSessionDatasource =
      RemoteSessionDatasource(httpClientHandler: httpHandler);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => SessionRepository(
            localSessionDatasource: sessionDatasource,
            remoteSessionDatasource: remoteSessionDatasource,
          ),
        ),
        RepositoryProvider(
          create: (_) => GoogleRepository(
            googleDatasource: googleDatasource,
            localSessionDatasource: sessionDatasource,
          ),
        ),
        RepositoryProvider(
          create: (_) => FacebookRepository(
            facebookDatasource: facebookDatasource,
            localSessionDatasource: sessionDatasource,
          ),
        )
      ],
      child: const App(),
    ),
  );
}
