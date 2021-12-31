import 'package:dataoke_sdk/network/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseBlogApiUtil {
  BaseBlogApiUtil._();
  factory BaseBlogApiUtil() => BaseBlogApiUtil._();
  static BaseBlogApiUtil get instance => BaseBlogApiUtil._();
  final util = DdTaokeUtil();

  /// get 请求
  Future<String> get(String url,
      {Map<String, dynamic>? data,
      ApiError? error,
      OnRequestStart? onStart,
      ResultDataMapHandle? mapData,
      CancelToken? cancelToken,
      ValueChanged<dynamic>? otherDataHandle}) async {
    return util.get(url,
        isTaokeApi: false,
        data: data,
        error: error,
        mapData: mapData,
        cancelToken: cancelToken,
        otherDataHandle: otherDataHandle);
  }

// post 请求
  Future<String> post(String url,
      {Map<String, dynamic>? data,
      ApiError? error,
      OnRequestStart? onStart,
      CancelToken? cancelToken,
      ValueChanged<dynamic>? otherDataHandle}) async {
    return util.post(url,
        isTaokeApi: false,
        onStart: onStart,
        data: data,
        error: error,
        otherDataHandle: otherDataHandle);
  }
}
