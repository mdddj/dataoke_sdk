

import 'dart:convert';

import '../v2/dio_base_api.dart';

//淘客请求统一封装
class TaokeRequest extends BaseApi{
  TaokeRequest() : super('/tkapi/api/v1/dtk/apis/request',httpMethod: HttpMethod.post);
  set url(String url)=>params['url'] = url;
  set version(String version)=> params['version'] = version;
  set data(Map<String,String> data)=> params['jsonString'] = jsonEncode(data);
}