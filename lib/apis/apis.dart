


import 'package:dataoke_sdk/v2/dio_base_api.dart';

class MeiTuanQuanApi extends BaseApi {
  MeiTuanQuanApi(): super('/api/zhe/mt/tg');
  set actId(String value) => params['actId'] = value; //2
  set linkType(String value) => params['linkType'] = value;//1
  set miniCode(String value) => params['miniCode'] = value;//1
}