import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/app.dart';
import 'package:pictures_finder/data/facebook_datasource.dart';
import 'package:pictures_finder/data/google_datasource.dart';
import 'package:pictures_finder/data/http_handler.dart';
import 'package:pictures_finder/repo/image_repository.dart';

void main() {
  const baseUri = 'http://128.199.246.141:3000';
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUri,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
  final httpHandler = HttpClientHandler(dio: dio);
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
