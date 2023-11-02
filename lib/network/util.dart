part of '../dataoke_sdk.dart';

typedef IfPrint = bool Function(String path);
extension DartTypeModelEx3 on DartTypeModel {
  void throwBizError() {
    whenOrNull(
      json: (value) {
        Logger().t(value);
        if (value.json.getValue('success') == false) {
          throw BaseApiException.businessException(message: value['message']);
        }
      },
    );
  }

  DartTypeModel getData() {
    throwBizError();
    return whenOrNull(
      json: (value) {
        return DartTypeModel.createFrom(value.json
            .getValue('data'));
      },
    ) ??
        const DartTypeModel.nil();
  }
}


class TKBaseApi extends BaseApi<DartTypeModel> {
  final String apiUrl;

  static BaseOptions opt = BaseOptions();

  TKBaseApi(this.apiUrl, {HttpMethod httpMethod = HttpMethod.get}) : super(apiUrl, httpMethod: httpMethod);


  @override
  Future<BaseOptions> get getOptions async => opt;

  @override
  DartTypeModel covertToModel(DartTypeModel data, RequestParams param) {
    return data;
  }





}

class DdTaokeUtil {
  DdTaokeUtil._();

  factory DdTaokeUtil() => instance;

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
  Future<String> get(String url,{RequestParams? requestParams,bool isTaokeApi = true}) async {
    if (isTaokeApi) {
      url = tkApi + url;
    }
    final api = TKBaseApi(url, httpMethod: HttpMethod.get);
    try {
      final r = await api.request(requestParams??const RequestParams());
      return r.getData().whenOrNull(string: (value) => value,json: jsonEncode).ifNullThrowBizException();
    } on BaseApiException catch (_) {
      rethrow;
    }

  }

  /// POST 请求
  Future<String> post(String url,
      {Map<String, dynamic>? data, OnRequestStart? onStart, ApiError? error, bool? isTaokeApi, ValueChanged<dynamic>? otherDataHandle}) async {
    if (isTaokeApi ?? true) {
      url = tkApi + url;
    }
    final api = TKBaseApi(url, httpMethod: HttpMethod.post);
    try {
      final r = await api.request(RequestParams(showDefaultLoading: false, data: data));
      return r.getData().whenOrNull(string: (value) => value,json: jsonEncode).ifNullThrowBizException();
    } on BaseApiException catch (_) {
      rethrow;
    }
  }
}

typedef ApiError = void Function(int stateCode, String message, dynamic data);

/// 发起请求前做的一些事
typedef OnRequestStart = DioStart;
typedef ResultDataMapHandle = void Function(Map<String, dynamic> map);
