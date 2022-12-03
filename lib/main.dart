import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pictures_finder/app.dart';
import 'package:pictures_finder/data/facebook_datasource.dart';
import 'package:pictures_finder/data/google_datasource.dart';
import 'package:pictures_finder/data/http_handler.dart';
import 'package:pictures_finder/repo/image_repository.dart';

const baseUri = 'http://34.143.233.85';

void main() {
  final httpHandler = HttpClientHandler(httpClient: http.Client());
  final googleDatasource = GoogleDatasource(httpHandler);
  final facebookDatasource = FacebookDatasource(httpHandler);

  runApp(
    RepositoryProvider(
      create: (_) => ImageRepository(
        googleDatasource: googleDatasource,
        facebookDatasource: facebookDatasource,
      ),
      child: const App(),
    ),
  );
}
