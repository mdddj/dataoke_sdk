import 'dart:convert';

import 'package:dd_js_util/api/base.dart';
import 'package:dd_js_util/api/exception.dart';
import 'package:dd_js_util/ext/map.dart';
import 'package:dd_js_util/util/log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class TKBaseApi extends BaseApi {
  final String apiUrl;
  TKBaseApi(this.apiUrl,{HttpMethod httpMethod = HttpMethod.get}):super(apiUrl,httpMethod:httpMethod);
}

class DdTaokeUtil{
  DdTaokeUtil._();
  factory DdTaokeUtil()=>DdTaokeUtil._();
  static DdTaokeUtil get instance => DdTaokeUtil();


  final tkApi = '/tkapi/api/v1/dtk/apis';



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
    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }
   final api =  TKBaseApi(url,httpMethod: HttpMethod.get);
   try{
     final r = await api.request(showDefaultLoading: false,data: data);
     final json = WrapJson(r as Map<String,dynamic>);
     if(json.getInt('state',defaultValue: 0) == 200){
       final dataString = json.getString('data');
       mapData?.call(jsonDecode(dataString));
       return dataString;
     }
   }on AppException catch(e){
     errorHandle(error, e.code , e.message);
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
    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }
    final api =  TKBaseApi(url,httpMethod: HttpMethod.post);
    try{
      final r = await api.request(showDefaultLoading: false,data: data);
      final json = WrapJson(r as Map<String,dynamic>);
      if(json.getInt('state',defaultValue: 0) == 200){
        final dataString = json.getString('data');
        return dataString;
      }
    }on AppException catch(e){
      errorHandle(error, e.code , e.message);
    }
    return '';
  }

  /// 请求没有正常执行
  void errorHandle(ApiError? error, int code, String message, {dynamic data}) {
    if (error != null) {
      error(code, message, data);
    } else {
      kLogErr('请求失败:code=$code.message=$message');
    }
  }

}

typedef ApiError = void Function(int stateCode, String message, dynamic data);


/// 发起请求前做的一些事
typedef OnRequestStart = void Function(Dio dio);
typedef ResultDataMapHandle = void Function(Map<String, dynamic> map);
