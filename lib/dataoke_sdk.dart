library dataoke_sdk;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dd_js_util/dd_js_util.dart';
import 'package:diox/diox.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'errors.dart';
import 'model/category.dart';


part './apis/apis.dart';
part './apis/taoke_request.dart';
part 'blog/base_api.dart';
part 'blog/blog_model.dart';
part 'blog/blog_service.dart';
part './constant/sort.dart';
part './model/base/favorite_model.dart';
part './model/jd/jd_product.dart';
part './model/jd/jd_req_param.dart';
part './model/pdd/pdd_category.dart';
part './model/activity_link_result.dart';
part './model/brand_detail_result.dart';
part './model/brand_list_model.dart';
part './model/carousel_model.dart';
part './model/coupon_link_result.dart';
part './model/ddq_result.dart';
part './model/detail_base_data.dart';
part './model/discount_two_result.dart';
part './model/ff_convert_convert_util.dart';
part './model/halfday_result.dart';
part './model/high_commission_result.dart';
part './model/history_price_result.dart';
part './model/hot_search_worlds_result.dart';
part './model/hotday_result.dart';
part './model/live_data_result.dart';
part './model/nine_nine_result.dart';
part './model/product.dart';
part './model/product_list_result.dart';
part './model/product_material_result.dart';
part './model/res_category.dart';
part './model/result.dart';
part './model/room_model.dart';
part './model/speider_resullt.dart';
part './model/super_search_result.dart';
part './model/system_pic.dart';
part './model/taobao_oneprice_result.dart';
part './model/user.dart';
part './model/wechat_result.dart';
part './network/util.dart';
part './params/activity_link_param.dart';
part './params/brand_param.dart';
part './params/brand_product_param.dart';
part './params/comment_param.dart';
part './params/coupons_detail_link_param.dart';
part './params/discount_two_param.dart';
part './params/high_commission_param.dart';
part './params/hotday_param.dart';
part './params/nine_nine_param.dart';
part './params/product_detail_param.dart';
part './params/product_list_param.dart';
part './params/shop_convert_param.dart';
part './params/speider_param.dart';
part './params/super_search_param.dart';
part './params/taobao_oneprice_param.dart';
part './params/top_param.dart';
part './params/wechat_param.dart';
part './constant/hive_keys.dart';
part 'dd_taoke_sdk.dart';
part 'public_api.dart';
part 'jd_api.dart';

class DataokeSdk {
  static const MethodChannel _channel = MethodChannel('dataoke_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
