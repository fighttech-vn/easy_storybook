// Copyright 2022 Fighttech.vn, Ltd. All rights reserved.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String prettyJsonStr(Map<dynamic, dynamic> json) {
  final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
  return encoder.convert(json);
}

class LoggerInterceptor extends Interceptor {
  final Function(DioException)? onRequestError;
  //For case response data is too large, dont need to show on log
  final bool Function(Response<dynamic>)? ignoreReponseDataLog;

  LoggerInterceptor({
    this.onRequestError,
    this.ignoreReponseDataLog,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      'from': 'onRequest',
      'Time': DateTime.now().toString(),
      'baseUrl': options.baseUrl,
      'path': options.path,
      'headers': options.headers,
      'method': options.method,
      'requestData': options.data,
      'queryParameters': options.queryParameters,
    }));
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      'from': 'onResponse',
      'Time': DateTime.now().toString(),
      'statusCode': response.statusCode,
      'baseUrl': response.requestOptions.baseUrl,
      'path': response.requestOptions.path,
      'method': response.requestOptions.method,
      if (ignoreReponseDataLog?.call(response) != false)
        'responseData': response.data,
    }));

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(prettyJsonStr({
      'from': 'onError',
      'Time': DateTime.now().toString(),
      'baseUrl': err.requestOptions.baseUrl,
      'header': err.requestOptions.headers,
      'path': err.requestOptions.path,
      'type': err.type,
      'message': err.message,
      'statusCode': err.response?.statusCode,
      'error': err.error,
      'responseData': err.requestOptions.data
    }));
    super.onError(err, handler);
  }
}
