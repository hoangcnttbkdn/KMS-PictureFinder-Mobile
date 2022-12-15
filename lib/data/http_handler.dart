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
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pictures_finder/data/http_exception.dart';
import 'package:pictures_finder/main.dart';

/// {@template httpdio_handler}
/// A http client handler for base api client
/// {@endtemplate}
class HttpClientHandler {
  /// {@macro httpdio_handler}
  HttpClientHandler({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<dynamic> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      log(
        Uri.parse('$baseUri$path').toString(),
        name: 'HTTP_CLIENT_HANDLER_GET',
      );
      return _httpClient
          .get(Uri.parse('$baseUri$path'), headers: headers)
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

   Future<dynamic> post(
    String path, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      log(
        Uri.parse('$baseUri$path').toString(),
        name: 'HTTP_CLIENT_HANDLER_GET',
      );
      return _httpClient
          .post(Uri.parse('$baseUri$path'),body: jsonEncode(body), headers: headers)
          .then(_handleResponse);
    } on SocketException {
      rethrow;
    }
  }

  Future<dynamic> postFile(
    String path, {
    required Map<String, String> fields,
    required http.MultipartFile multipartFile,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameter,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUri$path'))
      ..files.add(
        multipartFile,
      )
      ..headers
      ..fields.addAll(fields);
    final response = await request.send();
    return _handleResponse(await _fromStream(response));
  }

  dynamic _handleResponse(http.Response response) {
    log(response.body, name: 'HTTP_HANDLER');
    if (HttpStatus.ok <= response.statusCode &&
        response.statusCode <= HttpStatus.multipleChoices) {
      return jsonDecode(response.body);
    } else {
      final message = utf8.decode(response.bodyBytes);
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

  Future<Uint8List> _toBytes(
    http.ByteStream stream,
  ) {
    final completer = Completer<Uint8List>();
    final sink = ByteConversionSink.withCallback(
      (bytes) => completer.complete(Uint8List.fromList(bytes)),
    );

    stream.listen(
      sink.add,
      onError: completer.completeError,
      onDone: sink.close,
      cancelOnError: true,
    );

    return completer.future;
  }

  Future<http.Response> _fromStream(
    http.StreamedResponse response,
  ) async {
    final body = await _toBytes(response.stream);

    return http.Response.bytes(
      body,
      response.statusCode,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }
}