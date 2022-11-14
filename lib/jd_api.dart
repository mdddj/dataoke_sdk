part of dataoke_sdk;

//京东的接口
class JdApi {
  JdApi._();

  factory JdApi() => JdApi._();

  static JdApi get instance => JdApi._();

  final util = DdTaokeUtil();

  /// 京粉精选产品接口
  ///
  /// params:额外参数,详见[https://union.jd.com/openplatform/api/v2?apiName=jd.union.open.goods.jingfen.query]
  ///
  ///
  Future<String> getProducts(JdReqParam jdReqParam,
      {Map<String, dynamic>? params,ApiError? error}) async {
    final map = jdReqParam.toJson();
    if (params != null) {
      map.addAll(params);
    }
    return await util.get(_jdurl('products'), data: map, isTaokeApi: false,error: error);
  }

  /// 关键词查询接口
  ///
  /// params: 参数列表,文档[https://union.jd.com/openplatform/api/v2?apiName=jd.union.open.goods.query]
  ///
  Future<String> searchProducts({Map<String,dynamic>? params,ApiError? error}) async {
    return await util.get(_jdurl('search'),data: params??{},isTaokeApi: false,error: error);
  }

  String _jdurl(String url) {
    return '/api/jd/$url';
  }
}
