part of '../dataoke_sdk.dart';

/// 高效转链返回数据模型
class CouponLinkResult {
  CouponLinkResult({
    this.couponRemainCount,
    this.kuaiZhanUrl,
    this.minCommissionRate,
    this.originalPrice,
    this.couponInfo,
    this.actualPrice,
    this.shortUrl,
    this.maxCommissionRate,
    this.couponEndTime,
    this.couponTotalCount,
    this.itemId,
    this.couponStartTime,
    this.couponClickUrl,
    this.itemUrl,
    this.longTpwd,
    this.tpwd,
  });

  factory CouponLinkResult.fromJson(dynamic jsonRes) {
    return CouponLinkResult(
      couponRemainCount: asT<String>(jsonRes['couponRemainCount']),
      kuaiZhanUrl: asT<String>(jsonRes['kuaiZhanUrl']),
      minCommissionRate: asT<String>(jsonRes['minCommissionRate']),
      originalPrice: asT<double>(jsonRes['originalPrice']),
      couponInfo: asT<String>(jsonRes['couponInfo']),
      actualPrice: asT<double>(jsonRes['actualPrice']),
      shortUrl: asT<String>(jsonRes['shortUrl']),
      maxCommissionRate: asT<String>(jsonRes['maxCommissionRate']),
      couponEndTime: asT<String>(jsonRes['couponEndTime']),
      couponTotalCount: asT<String>(jsonRes['couponTotalCount']),
      itemId: asT<String>(jsonRes['itemId']),
      couponStartTime: asT<String>(jsonRes['couponStartTime']),
      couponClickUrl: asT<String>(jsonRes['couponClickUrl']),
      itemUrl: asT<String>(jsonRes['itemUrl']),
      longTpwd: asT<String>(jsonRes['longTpwd']),
      tpwd: asT<String>(jsonRes['tpwd']),
    );
  }

  String? couponRemainCount;
  String? kuaiZhanUrl;
  String? minCommissionRate;
  double? originalPrice;
  String? couponInfo;
  double? actualPrice;
  String? shortUrl;
  String? maxCommissionRate;
  String? couponEndTime;
  String? couponTotalCount;
  String? itemId;
  String? couponStartTime;
  String? couponClickUrl;
  String? itemUrl;
  String? longTpwd;
  String? tpwd;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'couponRemainCount': couponRemainCount,
        'kuaiZhanUrl': kuaiZhanUrl,
        'minCommissionRate': minCommissionRate,
        'originalPrice': originalPrice,
        'couponInfo': couponInfo,
        'actualPrice': actualPrice,
        'shortUrl': shortUrl,
        'maxCommissionRate': maxCommissionRate,
        'couponEndTime': couponEndTime,
        'couponTotalCount': couponTotalCount,
        'itemId': itemId,
        'couponStartTime': couponStartTime,
        'couponClickUrl': couponClickUrl,
        'itemUrl': itemUrl,
        'longTpwd': longTpwd,
        'tpwd': tpwd,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
