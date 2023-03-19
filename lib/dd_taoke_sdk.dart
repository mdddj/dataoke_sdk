part of dataoke_sdk;

typedef RequestParamsBuilder = RequestParams Function(RequestParams requestParams);

class DdTaokeSdk {
  DdTaokeSdk._();

  static DdTaokeSdk get instance => DdTaokeSdk._();

  factory DdTaokeSdk() => instance;

  final util = DdTaokeUtil();

  ///hive 适配器初始化
  Future<void> objectAdapterInit() async {
    Hive.registerAdapter(SubcategoryAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(CategoryWrapperAdapter());
    await Hive.openBox<CategoryWrapper>(kDDCategoryHiveBoxName);
  }

  ///清空缓存数据
  Future<void> objectsClean() async {
    Hive.box(kDDCategoryHiveBoxName).clear();
  }

  /// 获取超级分类
  Future<List<Category>> getCategorys({bool useCacheData = true}) async {
    final box = Hive.box<CategoryWrapper>(kDDCategoryHiveBoxName);
    if (useCacheData) {
      try {
        final cacheData = box.get('dtk', defaultValue: CategoryWrapper([]))!;
        if (cacheData.categorys.isNotEmpty) {
          return cacheData.categorys;
        }
      } catch (e) {
        throw AppException(code: 20002, message: "数据装换错误");
      }
    }
    final response = await util.get('/categorys');
    try {
      final categorys = categoryFromJson(response);

      box.put('dtk', CategoryWrapper(categorys));
      return response.isNotEmpty ? categorys : [];
    } catch (e) {
      throw AppException(code: 10001, message: '获取数据失败:$e');
    }
  }

  /// 获取轮播图
  Future<List<Carousel>> getCarousel({RequestParamsBuilder? requestParamsBuilder}) async {
    final response = await util.get(
      '/carousel-list',
      requestParams: requestParamsBuilder?.call(const RequestParams(showDefaultLoading: false))
    );
    return response.isNotEmpty ? carouselFromJson(response) : [];
  }

  /// 获取品牌列表
  Future<BrandListResult?> getBrandList({required BrandListParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    final response = await util.get('/brand-list', requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? brandListResultFromJson(response) : null;
  }

  /// 获取商品列表
  Future<ProductListResult?> getProducts({required ProductListParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    try {
      final response = await util.get('/goods', requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
      return response.isNotEmpty ? productListFromJson(response) : null;
    } catch (e) {
      rethrow;
    }
  }

  /// 获取商品详情
  Future<Product?> getProductDetail({required ProductDetailParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    final response = await util.get('/detail', requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? Product.fromJson(jsonDecode(response)) : null;
  }

  /// 获取品牌详情
  Future<BrandDetail?> getBrandDetail({required BrandProductParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    final response = await util.get('/brand-detail', requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? brandDetailFromJson(response) : null;
  }

  /// 高效转链
  /// [taobaoGoodsId] 是淘宝的商品id ,不是大淘客的id
  Future<CouponLinkResult?> getCouponsDetail({required String taobaoGoodsId, required RequestParamsBuilder requestParamsBuilder}) async {
    final response = await util.get('/privilege-link',
        requestParams: requestParamsBuilder.call(RequestParams(data: CouponsDetailParam(goodsId: taobaoGoodsId).toJson())));
    return response.isNotEmpty ? CouponLinkResult.fromJson(jsonDecode(response)) : null;
  }

  /// 获取商品详情页面所需的基本数据
  /// productId 大淘客商品id
  Future<DetailBaseDataResult> getDetailBaseData({required String productId, required RequestParamsBuilder requestParamsBuilder}) async {
    final response = await util.get('/product-detail-all/$productId', requestParams: requestParamsBuilder.call(const RequestParams()));
    try {
      DetailBaseDataResult? result;
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
            info: Product.fromJson(jsonDecode(info)), similarProducts: list, couponInfo: CouponLinkResult.fromJson(jsonDecode(coupon)));
        return result;
      }
    } catch (e) {
      rethrow;
    }
    throw AppException.appError();
  }

  /// 获取专题商品
  Future<List<Product>> getTopicProducts(String topic, int pageSize, int page, {required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/topic-goods';
    final response =
        await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {'topicId': topic, 'pageSize': pageSize, 'pageId': page})));
    try {
      final map = jsonDecode(response);
      final list = map['list'] as List<dynamic>;
      return list.covertFun<Product>(list, Product.fromJson);
    } catch (_) {
      rethrow;
    }
  }

  /// 获取高佣精选商品
  Future<HighCommissionResult?> getHighCommissionProducts(
      {required HighCommissionParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/high-commission';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? highCommissionResultFromJson(response) : null;
  }

  /// 获取商品的推广素材
  /// 商品精推素材
  /// [productId] 大淘客商品id或者淘宝商品id
  Future<ProductMaterialResult?> getProductMaterial({required String productId, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/product-material';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {"id": productId})));
    return (response.isNotEmpty ? (productMaterialResultFromJson(response).isNotEmpty ? productMaterialResultFromJson(response)[0] : null) : [])
        as FutureOr<ProductMaterialResult?>;
  }

  /// hot-search-worlds
  /// 热搜榜
  Future<List<HotSearchWorlds>> getHotSearchWorlds({RequestParamsBuilder? requestParamsBuilder}) async {
    const url = '/hot-search-worlds';
    final response = await util.get(
      url,
      requestParams: requestParamsBuilder?.call(const RequestParams(showDefaultLoading: false))
    );
    return response.isNotEmpty ? hotSearchWorldsFromJson(response) : [];
  }

  /// 获取线报
  Future<Map<String, dynamic>?> getSpeiderList({required SpeiderParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/speider';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? jsonDecode(response) : null;
  }

  /// 线报分支 整点抢购 topic = 3
  Future<SpeiderWithTimeResult?> getSpeiderListWithTime({
    required SpeiderParam param,
    required RequestParamsBuilder requestParamsBuilder
  }) async {
    param.topic = '3';
    final result = await getSpeiderList(
      param: param,
      requestParamsBuilder: requestParamsBuilder,
    );
    return result != null ? SpeiderWithTimeResult.fromJson(result) : null;
  }

  /// 超级搜索
  Future<SuperSearchResult?> superSearch({required SuperSearchParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/super-search';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? superSearchResultFromJson(response) : null;
  }

  /// 官方活动 (淘宝一元购)
  /// /taobao-oneprice_product
  Future<List<TaobaoOnePriceResult>> getTaobaoOnepriceProducts(
      {required TaobaoOnePriceParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/taobao-oneprice_product';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? taobaoOnePriceResultFromJson(response) : [];
  }

  /// 朋友圈文案
  Future<WechatResult?> getWechat({required WechatParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/wechat';
    final responst = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return responst.isNotEmpty ? WechatResult.fromJson(jsonDecode(responst)) : null;
  }

  /// 获取榜单商品
  Future<IList<Product>> getTopProducts({required TopParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/top';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? getProductsWithResponse(response) : const IListConst([]);
  }

  /// 九块九包邮
  Future<NineNineResult?> getNineNineProducts({required NineNineParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/nine-nine-goods';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? nineNineResultFromJson(response) : null;
  }

  /// 店铺转链
  Future<String> shopConvert({required ShopConvertParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/shop-convert';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response;
  }

  /// 细分类目商品
  /// /subdivision-goods
  Future<IList<Product>> getSubdivisionProducts({required String subdivisionId, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/subdivision-goods';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {'subdivisionId': subdivisionId})));
    return response.isNotEmpty ? getProductsWithResponse(response) : const IListConst([]);
  }

  /// 折上折 商品
  /// discount-goods
  Future<DiscountTwoResult?> getDiscountTwoProduct({required DiscountTwoParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/discount-goods';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? discountTwoResultFromJson(response) : null;
  }

  /// 每日半价
  /// halfday-goods
  Future<HalfdayResult?> getHalfdayProducts({String sessions = '', required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/halfday-goods';
    final response =
        await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: sessions.isNotEmpty ? {'sessions': sessions} : {})));
    return response.isNotEmpty ? halfdayResultFromJson(response) : null;
  }

  /// 获取商品的历史价格
  /// goods-history
  Future<HistoryPriceResult?> getProductHistoryPrice(
      {String productId = '', String taobaoGoodsId = '', required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/goods-history';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {'id': productId, 'goodsId': taobaoGoodsId})));
    return response.isNotEmpty ? historyPriceResultFromJson(response) : null;
  }

  /// 直播好货
  /// live-data
  Future<LiveDataResult?> getLiveDataProducts({String date = '', String sort = '0', required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/live-data';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {'date': date, 'sort': sort})));
    return response.isNotEmpty ? liveDataResultFromJson(response) : null;
  }

  /// 每日爆品
  /// hot-day
  Future<HotdayResult?> getHotDayProduct({required HotdayParam param, required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/hot-day';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())));
    return response.isNotEmpty ? hotdayResultFromJson(response) : null;
  }

  /// 咚咚抢
  /// ddq
  Future<DdqResult?> getDdq({String roundTime = '', required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/ddq';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(RequestParams(data: {'roundTime': roundTime})));
    return response.isNotEmpty ? ddqResultFromJson(response) : null;
  }

  /// 官方活动转链
  Future<ActivityLinkResult?> getActivityLink(ActivityLinkParam param, {required RequestParamsBuilder requestParamsBuilder}) async {
    const url = '/activity-link';
    final response = await util.get(
      url,
      requestParams: requestParamsBuilder.call(RequestParams(data: param.toJson())),
    );
    return response.isNotEmpty ? ActivityLinkResult.fromJson(jsonDecode(response)) : null;
  }

  /// 获取搜索推荐词语
  Future<List<String>> getSuggest({required RequestParamsBuilder requestParamsBuilder}) async {
    var result = <String>[];
    const url = '/search-worlds';
    final response = await util.get(url, requestParams: requestParamsBuilder.call(const RequestParams()));
    if (response.isNotEmpty) {
      final arr = jsonDecode(response)['hotWords'] as List<dynamic>;
      return List<String>.from(arr.map((e) => e.toString())).toList();
    }
    return result;
  }
}
