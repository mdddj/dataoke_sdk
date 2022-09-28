// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.


export './apis/apis.dart';
export './apis/taoke_request.dart';
export './blog/base_api.dart';
export './blog/blog_model.dart';
export './blog/blog_service.dart';
export './comment/base_page.dart';
export './constant/sort.dart';
export './model/base/favorite_model.dart';
export './model/jd/jd_product.dart';
export './model/jd/jd_req_param.dart';
export './model/pdd/pdd_category.dart';
export './model/activity_link_result.dart';
export './model/brand_detail_result.dart';
export './model/brand_list_model.dart';
export './model/carousel_model.dart';
export './model/category.dart';
export './model/coupon_link_result.dart';
export './model/ddq_result.dart';
export './model/detail_base_data.dart';
export './model/discount_two_result.dart';
export './model/ff_convert_convert_util.dart';
export './model/halfday_result.dart';
export './model/high_commission_result.dart';
export './model/history_price_result.dart';
export './model/hot_search_worlds_result.dart';
export './model/hotday_result.dart';
export './model/live_data_result.dart';
export './model/nine_nine_result.dart';
export './model/product.dart';
export './model/product_list_result.dart';
export './model/product_material_result.dart';
export './model/res_category.dart';
export './model/result.dart';
export './model/room_model.dart';
export './model/speider_resullt.dart';
export './model/super_search_result.dart';
export './model/system_pic.dart';
export './model/taobao_oneprice_result.dart';
export './model/user.dart';
export './model/wechat_result.dart';
export './network/util.dart';
export './params/activity_link_param.dart';
export './params/brand_param.dart';
export './params/brand_product_param.dart';
export './params/comment_param.dart';
export './params/coupons_detail_link_param.dart';
export './params/discount_two_param.dart';
export './params/high_commission_param.dart';
export './params/hotday_param.dart';
export './params/nine_nine_param.dart';
export './params/product_detail_param.dart';
export './params/product_list_param.dart';
export './params/shop_convert_param.dart';
export './params/speider_param.dart';
export './params/super_search_param.dart';
export './params/taobao_oneprice_param.dart';
export './params/top_param.dart';
export './params/wechat_param.dart';
export './dataoke_sdk.dart';
export './dataoke_sdk_web.dart';
export './dd_taoke_sdk.dart';
export './errors.dart';
export './jd_api.dart';
export './public_api.dart';


import 'dart:async';

import 'package:flutter/services.dart';

class DdDataokeSdk {
  static const MethodChannel _channel = MethodChannel('dd_dataoke_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
