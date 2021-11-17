import 'dart:async';
import 'dart:convert';

import 'model/activity_link_result.dart';
import 'model/brand_list_model.dart';
import 'model/category.dart';
import 'model/pdd/pdd_category.dart';
import 'model/product.dart';
import 'network/util.dart';
import 'params/activity_link_param.dart';
import 'params/brand_param.dart';
import 'params/brand_product_param.dart';
import 'params/comment_param.dart';
import 'params/coupons_detail_link_param.dart';
import 'params/discount_two_param.dart';
import 'params/high_commission_param.dart';
import 'params/hotday_param.dart';
import 'params/nine_nine_param.dart';
import 'params/product_detail_param.dart';
import 'params/product_list_param.dart';
import 'params/shop_convert_param.dart';
import 'params/speider_param.dart';
import 'params/super_search_param.dart';
import 'params/taobao_oneprice_param.dart';
import 'params/top_param.dart';
import 'params/wechat_param.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'model/brand_detail_result.dart';
import 'model/carousel_model.dart';
import 'model/coupon_link_result.dart';
import 'model/ddq_result.dart';
import 'model/detail_base_data.dart';
import 'model/discount_two_result.dart';
import 'model/halfday_result.dart';
import 'model/high_commission_result.dart';
import 'model/history_price_result.dart';
import 'model/hot_search_worlds_result.dart';
import 'model/hotday_result.dart';
import 'model/jd/jd_product.dart';
import 'model/live_data_result.dart';
import 'model/nine_nine_result.dart';
import 'model/product_list_result.dart';
import 'model/product_material_result.dart';
import 'model/speider_resullt.dart';
import 'model/super_search_result.dart';
import 'model/taobao_oneprice_result.dart';
import 'model/wechat_result.dart';

class DdTaokeSdk {
  DdTaokeSdk._();

  static DdTaokeSdk get instance => DdTaokeSdk._();

  factory DdTaokeSdk() => instance;

  final util = DdTaokeUtil();

  /// 获取超级分类
  Future<List<Category>> getCategorys({ApiError? error}) async {
    final response = await util.get('/categorys', error: error);
    return response.isNotEmpty ? categoryFromJson(response) : [];
  }

  /// 获取轮播图
  Future<List<Carousel>> getCarousel({ApiError? error}) async {
    final response = await util.get('/carousel-list', error: error);
    return response.isNotEmpty ? carouselFromJson(response) : [];
  }

  /// 获取品牌列表
  Future<BrandListResult?> getBrandList(
      {required BrandListParam param, ApiError? error}) async {
    final response =
        await util.get('/brand-list', data: param.toJson(), error: error);
    return response.isNotEmpty ? brandListResultFromJson(response) : null;
  }

  /// 获取商品列表
  Future<ProductListResult?> getProducts(
      {required ProductListParam param,
      ApiError? error,
      CancelToken? cancelToken}) async {
    final response = await util.get('/goods',
        data: param.toJson(), error: error, cancelToken: cancelToken);
    return response.isNotEmpty ? productListFromJson(response) : null;
  }

  /// 获取商品详情
  Future<Product?> getProductDetail(
      {required ProductDetailParam param, ApiError? error}) async {
    final response =
        await util.get('/detail', data: param.toJson(), error: error);
    return response.isNotEmpty ? productFromJson(response) : null;
  }

  /// 获取品牌详情
  Future<BrandDetail?> getBrandDetail(
      {required BrandProductParam param, ApiError? error}) async {
    final response =
        await util.get('/brand-detail', data: param.toJson(), error: error);
    return response.isNotEmpty ? brandDetailFromJson(response) : null;
  }

  /// 高效转链
  /// [taobaoGoodsId] 是淘宝的商品id ,不是大淘客的id
  Future<CouponLinkResult?> getCouponsDetail(
      {required String taobaoGoodsId, ApiError? error}) async {
    final response = await util.get('/privilege-link',
        data: CouponsDetailParam(goodsId: taobaoGoodsId).toJson(),
        error: error);
    return response.isNotEmpty
        ? CouponLinkResult.fromJson(jsonDecode(response))
        : null;
  }

  /// 获取商品详情页面所需的基本数据
  /// productId 大淘客商品id
  Future<DetailBaseDataResult?> getDetailBaseData(
      {required String productId, ApiError? apiError}) async {
    final response =
        await util.get('/product-detail-all/$productId', error: apiError);
    var result;

    if (response.isNotEmpty) {
      final map = jsonDecode(response);
      final info = map['detail'];
      final products = map['similarList'];
      final coupon = map['privieleLink'];

      var list = <Product>[];
      for (final item in jsonDecode(products)) {
        list.add(Product.fromJson(item));
      }

      result = DetailBaseDataResult(
          info: Product.fromJson(jsonDecode(info)),
          similarProducts: list,
          couponInfo: CouponLinkResult.fromJson(jsonDecode(coupon)));
    }

    return result;
  }

  /// 获取高佣精选商品
  Future<HighCommissionResult?> getHighCommissionProducts(
      {required HighCommissionParam param, ApiError? error}) async {
    final url = '/high-commission';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? highCommissionResultFromJson(response) : null;
  }

  /// 获取商品的推广素材
  /// 商品精推素材
  /// [productId] 大淘客商品id或者淘宝商品id
  Future<ProductMaterialResult?> getProductMaterial(
      {required String productId, ApiError? error}) async {
    final url = '/product-material';
    final response = await util.get(url, data: {"id": productId}, error: error);
    return (response.isNotEmpty
        ? (productMaterialResultFromJson(response).isNotEmpty
            ? productMaterialResultFromJson(response)[0]
            : null)
        : []) as FutureOr<ProductMaterialResult?>;
  }

  /// hot-search-worlds
  /// 热搜榜
  Future<List<HotSearchWorlds>> getHotSearchWorlds({ApiError? error}) async {
    final url = '/hot-search-worlds';
    final response = await util.get(url, error: error);
    return response.isNotEmpty ? hotSearchWorldsFromJson(response) : [];
  }

  /// 获取线报
  Future<Map<String, dynamic>?> getSpeiderList(
      {required SpeiderParam param, ApiError? error}) async {
    final url = '/speider';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? jsonDecode(response) : null;
  }

  /// 线报分支 整点抢购 topic = 3
  Future<SpeiderWithTimeResult?> getSpeiderListWithTime(
      {required SpeiderParam param, ApiError? error}) async {
    param.topic = '3';
    final result = await getSpeiderList(param: param, error: error);
    return result != null ? SpeiderWithTimeResult.fromJson(result) : null;
  }

  /// 超级搜索
  Future<SuperSearchResult?> superSearch(
      {required SuperSearchParam param, ApiError? error}) async {
    final url = '/super-search';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? superSearchResultFromJson(response) : null;
  }

  /// 官方活动 (淘宝一元购)
  /// /taobao-oneprice_product
  Future<List<TaobaoOnePriceResult>> getTaobaoOnepriceProducts(
      {required TaobaoOnePriceParam param, ApiError? error}) async {
    final url = '/taobao-oneprice_product';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? taobaoOnePriceResultFromJson(response) : [];
  }

  /// 朋友圈文案
  Future<WechatResult?> getWechat(
      {required WechatParam param, ApiError? error}) async {
    final url = '/wechat';
    final responst = await util.get(url, data: param.toJson(), error: error);
    return responst.isNotEmpty
        ? WechatResult.fromJson(jsonDecode(responst))
        : null;
  }

  /// 获取榜单商品
  Future<List<Product>> getTopProducts(
      {required TopParam param, ApiError? error}) async {
    final url = '/top';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? getProductsWithResponse(response) : [];
  }

  /// 九块九包邮
  Future<NineNineResult?> getNineNineProducts(
      {required NineNineParam param, ApiError? error}) async {
    final url = '/nine-nine-goods';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? nineNineResultFromJson(response) : null;
  }

  /// 获取商品评论
  @Deprecated('商品评论因为采集受限所以暂时没有数据')
  Future<String?> getProductComments(
      {required CommentParam param, ApiError? error}) async {
    final url = '/comment';
    final response = await util.get(url, error: error, data: param.toJson());
    return response;
  }

  /// 店铺转链
  Future<String> shopConvert(
      {required ShopConvertParam param, ApiError? error}) async {
    final url = '/shop-convert';
    final response = await util.get(url, error: error, data: param.toJson());
    Get.log(response);
    return response;
  }

  /// 细分类目商品
  /// /subdivision-goods
  Future<List<Product>> getSubdivisionProducts(
      {required String subdivisionId, ApiError? error}) async {
    final url = '/subdivision-goods';
    final response = await util
        .get(url, error: error, data: {'subdivisionId': subdivisionId});
    return response.isNotEmpty ? getProductsWithResponse(response) : [];
  }

  /// 折上折 商品
  /// discount-goods
  Future<DiscountTwoResult?> getDiscountTwoProduct(
      {required DiscountTwoParam param, ApiError? error}) async {
    final url = '/discount-goods';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? discountTwoResultFromJson(response) : null;
  }

  /// 每日半价
  /// halfday-goods
  Future<HalfdayResult?> getHalfdayProducts({
    String sessions = '',
    ApiError? error,
  }) async {
    final url = '/halfday-goods';
    final response = await util.get(url,
        error: error, data: sessions.isNotEmpty ? {'sessions': sessions} : {});
    return response.isNotEmpty ? halfdayResultFromJson(response) : null;
  }

  /// 获取商品的历史价格
  /// goods-history
  Future<HistoryPriceResult?> getProductHistoryPrice(
      {String productId = '',
      String taobaoGoodsId = '',
      ApiError? error}) async {
    final url = '/goods-history';
    final response = await util.get(url,
        error: error, data: {'id': productId, 'goodsId': taobaoGoodsId});
    return response.isNotEmpty ? historyPriceResultFromJson(response) : null;
  }

  /// 直播好货
  /// live-data
  Future<LiveDataResult?> getLiveDataProducts(
      {String date = '', String sort = '0', ApiError? error}) async {
    final url = '/live-data';
    final response =
        await util.get(url, data: {'date': date, 'sort': sort}, error: error);
    return response.isNotEmpty ? liveDataResultFromJson(response) : null;
  }

  /// 每日爆品
  /// hot-day
  Future<HotdayResult?> getHotDayProduct(
      {required HotdayParam param, ApiError? error}) async {
    final url = '/hot-day';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? hotdayResultFromJson(response) : null;
  }

  /// 咚咚抢
  /// ddq
  Future<DdqResult?> getDdq({String roundTime = '', ApiError? error}) async {
    final url = '/ddq';
    final response =
        await util.get(url, data: {'roundTime': roundTime}, error: error);
    return response.isNotEmpty ? ddqResultFromJson(response) : null;
  }

  /// 官方活动转链
  Future<ActivityLinkResult?> getActivityLink(ActivityLinkParam param,
      {ApiError? error}) async {
    final url = '/activity-link';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty
        ? ActivityLinkResult.fromJson(jsonDecode(response))
        : null;
  }

  /// 获取搜索推荐词语
  Future<List<String>> getSuggest({ApiError? apiError}) async {
    var result = <String>[];
    final url = '/search-worlds';
    final response = await util.get(url, error: apiError);
    if (response.isNotEmpty) {
      final _arr = jsonDecode(response)['hotWords'] as List<dynamic>;
      return List<String>.from(_arr.map((e) => e.toString())).toList();
    }
    return result;
  }

  /// 获取京东9块9包邮商品
  ///param [page] 页面
  ///param [pageSize] 返回数量大小
  ///param [sort] 0-综合排序；1-价格升序；2-价格降序
  ///缺少参数将会报错
  Future<List<JdProduct>> jdNinesList(int page, int pageSize, int sort,
      {ApiError? apiError}) async {
    final url = '/jd-nines';
    var result = <JdProduct>[];
    await util
        .get(url, data: {'pageId': page, 'pageSize': pageSize, 'sort': sort},
            mapData: (data) {
      final list = data['list'];
      if (list is List<dynamic>) {
        result = List<JdProduct>.from((list).map((e) => JdProduct.fromJson(e)))
            .toList();
      }
    }, error: apiError);
    return result;
  }

  /// 获取京东产品数据
  /// param [sku] 京东产品id
  Future<JdProduct?> jdDetail(String sku, {ApiError? error}) async {
    final url = '/jd-detail';
    JdProduct? result;
    final jsonString = await util.get(url, data: {'sku': sku}, error: error);
    Get.log(jsonString);
    if (jsonString.isNotEmpty) {
      final data = jsonDecode(jsonString);
      if (data is List<dynamic> && data.isNotEmpty) {
        final item = data[0];
        try {
          result = JdProduct.fromJson(item);
        } catch (e) {
          print('解析京东产品数据失败');
        }
      }
    }
    return result;
  }

  /// 获取京东排行榜单商品
  Future<List<JdProduct>> jdPhb(int page, int pageSize,
      {ApiError? error}) async {
    var result = <JdProduct>[];
    final url = '/jd-phb';
    await util.get(url, data: {'page': page, 'pageSize': pageSize},
        mapData: (data) {
      final list = data['list'];
      if (list is List<dynamic>) {
        result = List<JdProduct>.from((list).map((e) => JdProduct.fromJson(e)))
            .toList();
      }
    }, error: error);
    return result;
  }

  /// 获取京东大牌折扣
  Future<List<JdProduct>> jdDpzk(int page, int pageSize,
      {ApiError? error}) async {
    var result = <JdProduct>[];
    final url = '/jd-dpzk';
    await util.get(url, data: {'page': page, 'pageSize': pageSize},
        mapData: (data) {
      final list = data['list'];
      if (list is List<dynamic>) {
        result = List<JdProduct>.from((list).map((e) => JdProduct.fromJson(e)))
            .toList();
      }
    }, error: error);
    return result;
  }

  /// 获取拼多多的分类数据
  ///
  /// parentId 如果是一级分类填0
  ///
  /// 文档地址： 【https://www.dataoke.com/kfpt/api-d.html?id=82】
  ///
  Future<List<JdOrPddCategory>> getPddCategory(String parentId,
      {ApiError? error}) async {
    final response = await util.get('/pdd-category',
        data: {'parentId': parentId}, error: error);
    try {
      return response.isEmpty ? [] : JdOrPddCategoryFromJson(response);
    } catch (_) {
      error?.call(8000, '程序内部错误', null);
      return [];
    }
  }


  /// 获取京东的分类数据
  Future<List<JdOrPddCategory>> getJdCategory({String? parentId,String? level,ApiError? error}) async {
    final param = <String, dynamic>{};
    if(parentId!=null){
      param['parentId'] = parentId;
    }
    if(level!=null){
      param['level'] = level;
    }
    final response = await util.get('/jd-category',
        data:param, error: error);
    try {
      return response.isEmpty ? [] : JdOrPddCategoryFromJson(response);
    } catch (_) {
    error?.call(8000, '程序内部错误', null);
    return [];
    }
}
}
