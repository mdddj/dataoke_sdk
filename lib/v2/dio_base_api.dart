import 'dart:convert';

import 'package:dataoke_sdk/network/util.dart';
import 'package:dio/dio.dart';

enum HttpMethod { post, get }

typedef ParseObject = dynamic Function(dynamic originMap);

extension ListExt on List<dynamic> {
  List<T> parseObj<T>(ParseObject covert) {
    return List<T>.from(map(covert)).toList();
  }
}

extension ResultJsonExt on ResultJson? {
  bool get requestIsSuccess => this!=null && this!.success == true && this!.errors.isEmpty;
}

abstract class BaseModel<T> {
  T fromJson(Map<String, dynamic> map);
}

class ResultJson {
  final bool success;
  final String errorMessage;
  final List<dynamic> errors;
  final dynamic data;

  ResultJson(
      {required this.success,
        required this.errorMessage,
        required this.errors,
        required this.data});

  factory ResultJson.fromJson(Map<String, dynamic> map) {
    return ResultJson(
        success: map['success'],
        errorMessage: map['errorMessage'] ?? '',
        errors: map['errors'] ?? [],
        data: map['data']);
  }

  //打印
  void printDataJson() {
    print(jsonEncode(data));
  }

  //转数组
  List<dynamic> parseList() {
    return data as List<dynamic>;
  }

  List<T> dataCovertToList<T>(ParseObject covert) {
    return parseList().parseObj<T>(covert).toList();
  }

  @override
  String toString() {
    return '==========================================\n是否成功:${success ? '成功' : '失败'} data类型:${data.runtimeType} \n错误消息:$errorMessage\n错误列表:$errors\n数据:$data\n==========================================';
  }
}

abstract class BaseApi {
  static String host =  DdTaokeUtil.instance.ip + ':' +  DdTaokeUtil.instance.port;
  final String url;
  final HttpMethod httpMethod;
  final Map<String, dynamic> params = <String, dynamic>{};

  BaseApi(this.url, {this.httpMethod = HttpMethod.get});

  Future<ResultJson?> request() async {
    final response = await Dio().request(host + url,
        options: Options(method: methed),
        queryParameters: params,
        data: params);
    if (response.statusCode == 200) {
      final data = response.data;
      return ResultJson.fromJson(data);
    }
    return null;
  }

  //请求方法,
  String get methed => getMethod();

  String getMethod() {
    switch (httpMethod) {
      case HttpMethod.get:
        return 'GET';
      default:
        return "POST";
    }
  }
}
