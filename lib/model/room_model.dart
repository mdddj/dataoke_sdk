part of dataoke_sdk;

class GameRoomModel {
  String roomName;
  User? roomCreateUser;
  User? pkUser;

  GameRoomModel({required this.roomName, this.pkUser, this.roomCreateUser});

  // 转换
  factory GameRoomModel.fromJson(Map<String, dynamic> res) {
    final u1 = res['roomCreateUser'];
    User? createUser = u1!=null ? User.fromJson(u1) : null;
    final u2 = res['pkUser'];
    User? pkUser = u2!=null ? User.fromJson(u2) : null;
    return GameRoomModel(roomName: res['roomName'].toString(),roomCreateUser: createUser,pkUser: pkUser);
  }


  /// 获取全部房间的转换
  static List<GameRoomModel> covertFromRoomsApi(String result){
    final map = jsonDecode(result);
    final list = List<GameRoomModel>.from((map as List<dynamic>).map((e) => GameRoomModel.fromJson(jsonDecode(e)))).toList();
    return list;
  }
}
