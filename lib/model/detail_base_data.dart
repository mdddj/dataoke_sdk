
part of dataoke_sdk;

class DetailBaseDataResult {
  Product? info; // 商品的基本信息
  List<Product>? similarProducts; // 相似列表,默认10条
  CouponLinkResult? couponInfo; // 领券相关

  DetailBaseDataResult({this.info, this.couponInfo, this.similarProducts});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'info': jsonEncode(info),
      'similarProducts': jsonEncode(similarProducts),
      'couponInfo': couponInfo.toString()
    };
  }
}
