import 'dart:convert';

import 'package:commons/log.dart';
import 'package:commons/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:service/api/enum.dart';
import 'package:service/api/http_service_exception_model.dart';
import 'package:service/api/service_exception.dart';

import 'api_core.dart';
import 'header.dart';

class DioProvider {
  final Dio _dio = Dio();
  final CancelToken _cancelToken = CancelToken();
  final Map<String, dynamic> bytes = {};
  final ApiCore _apiCore;
  late Map<String, String>? _header;

  Response _response = Response(
    requestOptions: RequestOptions(),
    statusCode: 500,
    data: {'status': 500, 'message': 'erroGenerico'},
  );
  String _url = '';

  DioProvider.of(this._apiCore) {
    _header = _apiCore.isLogged ? Header.buildHeadersLoggedUser() : Header.buildHeaders();
    _url = _apiCore.des + _apiCore.endpoint;
    if (kReleaseMode) {
      _url = _apiCore.prd + _apiCore.endpoint;
    }
  }

  Future<Result<Map<String, dynamic>>> request({
    required Verb verb,
    dynamic pathParam,
    dynamic queryParam,
    Map? body,
    int timeout = 30,
  }) async {
    var stopWatch = Stopwatch();
    stopWatch.start();

    final options = Options(
      method: verb.name,
      headers: _header,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
      sendTimeout: Duration(seconds: timeout),
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(minutes: 1),
    );

    pathParam = pathParam != null ? '/$pathParam' : '';
    queryParam = queryParam != null ? '?$queryParam' : '';

    Uri uri = Uri.parse("$_url$pathParam$queryParam");

    try {
      switch (verb) {
        case Verb.get:
          _response = await _dio.getUri(
            uri,
            cancelToken: _cancelToken,
            options: options,
            onReceiveProgress: (count, total) => _receiveProgress(count, total),
          );
          break;
        case Verb.post:
          _response = await _dio.postUri(
            uri,
            cancelToken: _cancelToken,
            options: options,
            data: body != null ? _nonNull(body) : null,
            onReceiveProgress: (count, total) => _receiveProgress(count, total),
            onSendProgress: (count, total) => _sendProgress(count, total),
          );
          break;
        case Verb.delete:
          _response = await _dio.deleteUri(uri, cancelToken: _cancelToken, options: options);
          break;
        case Verb.put:
          _response = await _dio.putUri(
            uri,
            options: options,
            cancelToken: _cancelToken,
            data: _nonNull(body!),
            onReceiveProgress: (count, total) => _receiveProgress(count, total),
            onSendProgress: (count, total) => _sendProgress(count, total),
          );
          break;
      }
      return Result.ok(Map<String, dynamic>.from(_response.data as Map));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        return Result.ok({});
      }
      _response = e.response ?? _response;

      HttpServiceExceptionModel responseModel = HttpServiceExceptionModel.fromJson(json.decode(_response.toString()));

      throw HttpServiceException(
        code: _response.statusCode,
        exception: e,
        message: responseModel.message,
        debugMessage: _response.data,
      );
    } finally {
      int status = _response.statusCode ?? 500;
      stopWatch.stop();
      var elapsedSeconds = stopWatch.elapsed.inSeconds;
      var elapsedMilliseconds = stopWatch.elapsed.inMilliseconds;

      Log.print(
        '${_apiCore.endpoint}, s: $elapsedSeconds, ms: $elapsedMilliseconds',
        title: 'Provider ${verb.name.toUpperCase()} $status',
      );
      if (body != null) Log.printJson(body, title: 'Provider Body');
      if (pathParam != null) Log.print(pathParam.toString(), title: 'Provider Param');
      // Log.printJson(resp.toString().substring(0, 500), titulo: 'Provider Response');
    }
  }

  void cancel() {
    bool isCancel = _cancelToken.isCancelled;
    if (!isCancel) {
      _cancelToken.cancel();
    }
  }

  Future<void> _receiveProgress(count, total) async {
    bytes.addAll({
      'download': {'count': count, 'total': total},
    });
  }

  Future<void> _sendProgress(count, total) async {
    bytes.addAll({
      'upload': {'count': count, 'total': total},
    });
  }

  Map<dynamic, dynamic> _nonNull(Map body) {
    body.removeWhere((key, value) => value == null || value == '');
    return body;
  }
}
