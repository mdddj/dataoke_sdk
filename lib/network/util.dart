import 'dart:convert';
import 'dart:io';

import '../model/result.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class DdTaokeUtil {
  DdTaokeUtil._();

  static DdTaokeUtil get instance => DdTaokeUtil._();

  factory DdTaokeUtil() => instance;

  static Dio? dio;
  final tkApi = '/tkapi/api/v1/dtk/apis';
  static var _ip = '';
  static var _port = '';
  static var _proxy = '';
  static var _print = true;
  static var _showParams = true;

  String get ip => _ip;

  String get port => _port;

  OnRequestStart? _onStart;

  /// 初始化服务器地址和端口
  void init(String host, String port,
      {String? proxy,
      OnRequestStart? onStart,
      bool debug = true,
      bool printParams = true}) {
    _print = debug;
    _showParams = printParams;
    _ip = host;
    _port = port;
    if (proxy != null) _proxy = proxy;
    _onStart = onStart;
  }

  ///发起http请求
  ///
  ///url 接口地址
  ///
  ///data 查询参数
  ///
  ///error 请求错误回传
  ///
  Future<String> get(String url,
      {Map<String, dynamic>? data,
      ApiError? error,
      OnRequestStart? onStart,
      bool? isTaokeApi,
      ResultDataMapHandle? mapData,
      CancelToken? cancelToken,
      ValueChanged<dynamic>? otherDataHandle}) async {
    Logger().d(url);
    if (_showParams && data != null) {
      Logger().wtf(jsonEncode(data));
    }
    var _dio = createInstance()!;
    if (_proxy.isNotEmpty) addProxy(_dio, _proxy);
    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }

    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    // if(kIsWeb){
    //   var adapter = BrowserHttpClientAdapter();
    //   adapter.withCredentials = true;
    //   _dio.httpClientAdapter = adapter;
    // }

    _onStart?.call(_dio); // 全局的
    onStart?.call(_dio); // 局部的
    try {
      final response = await _dio.get<String>(url,
          queryParameters: data, cancelToken: cancelToken);
      if (response.statusCode == 200 && response.data != null) {
        final result = ddTaokeResultFromJson(response.data!);
        if (result.state == 200) {
          if (result.data != null) {
            try {
              if (_print) {
                Logger().i(jsonDecode(result.data!));
              }
              mapData?.call(jsonDecode(result.data!));
              otherDataHandle?.call(result.otherData);
            } catch (_) {}
            return result.data!;
          }
          return '';
        } else {
          errorHandle(error, result.state, result.message, data: result.data);
          return '';
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        errorHandle(error, e.response!.statusCode ?? -1,
            e.response!.statusMessage ?? '请求失败');
      }
      errorHandle(error, 500, '${e.toString()}');
    }

    return '';
  }

  /// POST 请求
  Future<String> post(String url,
      {Map<String, dynamic>? data,
      OnRequestStart? onStart,
      ApiError? error,
      bool? isTaokeApi,
      ValueChanged<dynamic>? otherDataHandle}) async {
    var _dio = createInstance()!;
    if (_proxy.isNotEmpty) addProxy(_dio, _proxy);
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    _onStart?.call(_dio);
    onStart?.call(_dio);

    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }

    try {
      final response = await _dio.post(url,
          data: data,
          options: Options(
              method: 'POST',
              followRedirects: false,
              contentType: 'application/json'));

      if (response.statusCode == 200 && response.data != null) {
        final _data = response.data is Map<String, dynamic>
            ? jsonEncode(response.data)
            : response.data;
        final result = ddTaokeResultFromJson(_data);
        if (result.state == 200) {
          if (result.data != null) {
            return result.data!;
          }
          return '';
        } else {
          errorHandle(error, result.state, result.message, data: result.data);
          return '';
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        errorHandle(error, e.response!.statusCode ?? -1,
            e.response!.statusMessage ?? '请求失败');
      }
      errorHandle(error, 500, '${e.toString()}');
    }

    return '';
  }

  /// 请求没有正常执行
  void errorHandle(ApiError? error, int code, String message, {dynamic data}) {
    if (error != null) {
      error(code, message, data);
    } else {
      print('请求失败:code=$code.message=$message');
    }
  }

  /// 创建dio实例
  Dio? createInstance() {
    if (dio == null) {
      final url = '$_ip:$_port';
      BaseOptions options = BaseOptions(
        baseUrl: url,
        connectTimeout: 20000,
      );
      dio = Dio(options);
    }
    return dio;
  }
}

typedef ApiError = void Function(int stateCode, String message, dynamic data);

void addProxy(Dio dio, String ip) {
  var client;
  if (ip.isNotEmpty) {
    if (kIsWeb) {
    } else {
      client = dio.httpClientAdapter as DefaultHttpClientAdapter;
      client.onHttpClientCreate = (_client) {
        _client.findProxy = (uri) {
          return "PROXY $ip";
        };
      };
    }
  }
}

/// 发起请求前做的一些事
typedef OnRequestStart = void Function(Dio dio);
typedef ResultDataMapHandle = void Function(Map<String, dynamic> map);
