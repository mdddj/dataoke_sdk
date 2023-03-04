part of dataoke_sdk;


typedef IfPrint = bool Function(String path);

class TKBaseApi extends BaseApi {
  final String apiUrl;
  TKBaseApi(this.apiUrl,{HttpMethod httpMethod = HttpMethod.get}):super(apiUrl,httpMethod:httpMethod);
}

class DdTaokeUtil{
  DdTaokeUtil._();
  factory DdTaokeUtil()=> instance;
  static DdTaokeUtil get instance => DdTaokeUtil._();


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
      ValueChanged<dynamic>? otherDataHandle,IfPrint? ifPrint}) async {
    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }
   final api =  TKBaseApi(url,httpMethod: HttpMethod.get);
   try{
     final r = await api.request(RequestParams(showDefaultLoading: false,data: data,dioStart:onStart));

     if(r is String) {
       throw AppException.appError();
     }
     final json = WrapJson(r as Map<String,dynamic>);
     if(ifPrint?.call(url) == true){
       json.print();
     }
     if(json.getInt('state') == 200){
       final data =  json.getValue('data');
       if(data is String) {
         mapData?.call(jsonDecode(data));
         return data;
       }else{
         mapData?.call(data as Map<String,dynamic>);
         return jsonEncode(data);
       }

     }
   } on AppException catch(_){
     rethrow;
   }
   throw AppException(code: -10001, message: '获取数据失败');
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
      final r = await api.request(RequestParams(showDefaultLoading: false,data: data));
      final json = WrapJson(r as Map<String,dynamic>);
      if(json.getInt('state',defaultValue: 0) == 200){
        final dataString = json.getString('data');
        return dataString;
      }else{
        throw AppException(code: json.getInt('state'), message:  json.getString('message'));
      }
    }on AppException catch(_){
      rethrow;
    }
  }


}

typedef ApiError = void Function(int stateCode, String message, dynamic data);


/// 发起请求前做的一些事
typedef OnRequestStart = DioStart;
typedef ResultDataMapHandle = void Function(Map<String, dynamic> map);
