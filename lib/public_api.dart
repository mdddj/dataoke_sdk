import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/room_model.dart';
import 'model/system_pic.dart';
import 'model/user.dart';
import 'network/util.dart';

const userApiUrl = '/api/public/user';

class PublicApi {
  PublicApi._();

  factory PublicApi() => PublicApi._();

  static PublicApi get req => PublicApi._();

  final util = DdTaokeUtil();

  /// 注册一个典典账号
  ///
  /// [loginName] : 登录用户名,登录名不能小于5个字符
  ///
  /// [password] : 用户登录密码,登录密码不能少于6个字符
  ///
  /// [pic] : 用户的头像url,请输入一个有效url
  ///
  Future<bool> register(String loginName, String password, String pic,
      {ApiError? apiError, ValueChanged<dynamic>? otherDataHandle}) async {
    final result = await util.post('$userApiUrl/registor',
        isTaokeApi: false,
        data: {'loginName': loginName, 'password': password, 'pic': pic},
        error: apiError,
        otherDataHandle: otherDataHandle);
    return result == '注册成功';
  }

  /// 执行用户登录
  ///
  /// [tokenHandle] : 返回一个jwt token 进行鉴权验证
  ///
  /// [loginFail] : 登录失败
  ///
  /// return : true 表示登录成功
  Future<bool> login(String username, String password,
      {ValueChanged<String>? tokenHandle,
      ValueChanged<String>? loginFail}) async {
    final result = await util.post(
      '/api/user/login',
      data: {'loginNumber': username, 'password': password},
      error: (int code, String msg, data) {
        loginFail?.call(msg);
      },
      isTaokeApi: false,
    );
    if (result.isNotEmpty) {
      tokenHandle?.call(result);
      return true;
    }
    return false;
  }

  /// 根据jwt token 获取用户对象信息
  ///
  /// [start] : 请求开始时执行的方法,
  Future<User?> getUser(String token, {OnRequestStart? start}) async {
    final result = await util.get('/api/get-user-by-token',
        data: {'token': token}, onStart: start, isTaokeApi: false);

    if (result.isNotEmpty) {
      try {
        return User.fromJson(jsonDecode(result));
      } catch (e, s) {
        print(e);
        print(s);
        return null;
      }
    }
    return null;
  }

  /// 获取系统的预设头像
  Future<List<SystemPic>> getAvaPics() async {
    final resutl = await util.get('$userApiUrl/ava-pics', isTaokeApi: false);
    return resutl.isNotEmpty
        ? List<SystemPic>.from((jsonDecode(resutl) as List<dynamic>)
            .map((e) => SystemPic.fromJson(e))).toList()
        : <SystemPic>[];
  }

  /// 创建游戏房间
  ///
  /// [userId] : 用户id,房间创始人
  ///
  /// [roomName] : 房间名字
  ///
  Future<GameRoomModel?> createRoom(int userId, String roomName,
      {ApiError? error}) async {
    final result = await util.post('$userApiUrl/create-room',
        isTaokeApi: false,
        data: {'name': roomName, 'userId': userId},
        error: error);

    return result.isNotEmpty
        ? GameRoomModel.fromJson(jsonDecode(result))
        : null;
  }

  /// 获取所有的房间
  Future<List<GameRoomModel>> getAllRoom({ApiError? error}) async {
    final result =
        await util.get('$userApiUrl/rooms', isTaokeApi: false, error: error);
    if (result.isNotEmpty) {
      return GameRoomModel.covertFromRoomsApi(result);
    }
    return [];
  }

  /// 获取当前在线的总人数
  Future<String> getInlineUserCount() async {
    final result =
        await util.get('$userApiUrl/inline-count', isTaokeApi: false);
    return result;
  }

  /// 删除一个房间
  ///
  /// 此api需要用户登录授权
  Future<void> removeRoom(String name) async {
    await util.post('$userApiUrl/remove-room',
        data: {'name': name}, isTaokeApi: false);
  }

  /// 进入一个房间
  Future<void> inRoom(String userId, String roomName) async {
    await util.post('$userApiUrl/in-room',
        data: {'userId': userId, 'roomName': roomName}, isTaokeApi: false);
  }
}
