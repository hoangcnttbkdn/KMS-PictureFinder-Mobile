// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pictures_finder/data/http_exception.dart';

/// {@template httpdio_handler}
/// A http client handler for base api client
/// {@endtemplate}
class HttpClientHandler {
  /// {@macro httpdio_handler}
  HttpClientHandler({
    Dio? dio,
  }) : dio = dio ?? Dio();

  final Dio dio;

  Future<String> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      return dio
          .get(path, options: Options(headers: headers))
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<String> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      return dio
          .post(
            path,
            options: Options(headers: headers),
            data: body,
          )
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<String> postFile(
    String path, {
    required FormData formData,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    log(formData.files.toString());
    log(formData.fields.toString());

    final response = await dio.post(
      path,
      data: formData,
    );
    return _handleResponse(response);
  }

  String _handleResponse(Response response) {
    log(response.data, name: 'HTTPdio_HANDLER');
    if (HttpStatus.ok <= response.statusCode! &&
        response.statusCode! <= HttpStatus.multipleChoices) {
      return utf8.decode(response.data);
    } else {
      final message = utf8.decode(response.data);
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message: message);
        case 413:
          throw PayloadTooLargeException(message: message);
        case 500:
          throw ServerErrorException(message: message);
        default:
          throw Exception(
            'Error occured while Communication'
            ' with Server with StatusCode : ${response.statusCode}',
          );
      }
    }
  }

  // Future<Uint8List> _toBytes(
  //   http.ByteStream stream,
  // ) {
  //   final completer = Completer<Uint8List>();
  //   final sink = ByteConversionSink.withCallback(
  //     (bytes) => completer.complete(Uint8List.fromList(bytes)),
  //   );

  //   stream.listen(
  //     sink.add,
  //     onError: completer.completeError,
  //     onDone: sink.close,
  //     cancelOnError: true,
  //   );

  //   return completer.future;
  // }

  // Future<http.Response> _fromStream(
  //   http.StreamedResponse response,
  // ) async {
  //   final body = await _toBytes(response.stream);

  //   return http.Response.bytes(
  //     body,
  //     response.statusCode,
  //     request: response.request,
  //     headers: response.headers,
  //     isRedirect: response.isRedirect,
  //     persistentConnection: response.persistentConnection,
  //     reasonPhrase: response.reasonPhrase,
  //   );
  // }

}
