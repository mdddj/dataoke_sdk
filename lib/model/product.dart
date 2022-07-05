
import 'dart:convert';

import 'base/favorite_model.dart';

List<Product> getProductsWithResponse(String str) =>
    List<Product>.from(jsonDecode(str).map((x) => Product.fromJson(x)));

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product extends FavoriteModel{
  Product(
      {this.teamName,
      this.tbcid,
      this.shipPercent,
      this.freeshipRemoteDistrict,
      this.yunfeixian,
      this.itemLink,
      this.goldSellers,
      this.reimgs,
      this.couponLink,
      this.haitao,
      this.sellerId,
      this.discounts,
      this.directCommissionLink,
      this.couponStartTime,
      this.serviceScore,
      this.mainPic,
      this.tchaoshi,
      this.id,
      this.brand,
      this.imgs,
      this.brandName,
      this.subcid,
      this.couponConditions,
      this.detailPics,
      this.subdivisionId,
      this.dsrScore,
      this.shopLogo,
      this.dailySales,
      this.shopLevel,
      this.couponTotalNum,
      this.descScore,
      this.brandWenan,
      this.activityEndTime,
      this.shipScore,
      this.brandId,
      this.couponReceiveNum,
      this.shopType,
      this.desc,
      this.cid,
      this.commissionRate,
      this.originalPrice,
      this.actualPrice,
      this.goodsId,
      this.quanMLink,
      this.shopName,
      this.activityStartTime,
      this.video,
      this.title,
      this.dtitle,
      this.monthSales,
      this.subdivisionRank,
      this.hzQuanOver,
      this.isSubdivision,
      this.marketingMainPic,
      this.directCommissionType,
      this.servicePercent,
      this.commissionType,
      this.couponEndTime,
      this.directCommission,
      this.twoHoursSales,
      this.createTime,
      this.dsrPercent,
      this.estimateAmount,
      this.specialText,
      this.couponPrice,
      this.activityType,
      this.hotPush,
      this.subdivisionName,
      this.circleText});

  String? teamName;
  int? tbcid;
  double? shipPercent;
  int? freeshipRemoteDistrict;
  int? yunfeixian;
  String? itemLink;
  int? goldSellers;
  String? reimgs;
  String? couponLink;
  int? haitao;
  String? sellerId;
  double? discounts;
  String? directCommissionLink;
  String? couponStartTime;
  double? serviceScore;
  String? mainPic;
  int? tchaoshi;
  int? id;
  int? brand;
  String? imgs;
  String? brandName;
  List<int>? subcid;
  String? couponConditions;
  String? detailPics;
  int? subdivisionId;
  double? dsrScore;
  String? shopLogo;
  int? dailySales;
  String? shopLevel;
  int? couponTotalNum;
  double? descScore;
  String? brandWenan;
  String? activityEndTime;
  String? shipScore;
  int? brandId;
  int? couponReceiveNum;
  int? shopType;
  String? desc;
  int? cid;
  double? commissionRate;
  double? originalPrice;
  double? actualPrice;
  String? goodsId;
  int? quanMLink;
  String? shopName;
  String? activityStartTime;
  String? video;
  String? title;
  String? dtitle;
  int? monthSales;
  int? subdivisionRank;
  int? hzQuanOver;
  int? isSubdivision;
  String? marketingMainPic;
  int? directCommissionType;
  double? servicePercent;
  int? commissionType;
  String? couponEndTime;
  double? directCommission;
  int? twoHoursSales;
  String? createTime;
  double? dsrPercent;
  double? estimateAmount;
  List<dynamic>? specialText;
  double? couponPrice;
  int? activityType;
  int? hotPush;
  String? subdivisionName;
  String? circleText;

  factory Product.fromJson(Map<String, dynamic> json) {
    final tChaoshi = json['tchaoshi'] is String ? int.parse(json['tchaoshi']) : json['tchaoshi'] as int;
    return Product(
        teamName: json["teamName"],
        tbcid:
            json["tbcid"] is String ? int.parse(json["tbcid"]) : json["tbcid"],
        shipPercent: json["shipPercent"]?.toDouble(),
        freeshipRemoteDistrict: json["freeshipRemoteDistrict"],
        yunfeixian: json["yunfeixian"],
        itemLink: json["itemLink"],
        goldSellers: json["goldSellers"],
        reimgs: json["reimgs"],
        couponLink: json["couponLink"],
        haitao: json["haitao"],
        sellerId: json["sellerId"],
        discounts: json["discounts"]?.toDouble(),
        directCommissionLink: json["directCommissionLink"],
        couponStartTime: json["couponStartTime"],
        serviceScore: json["serviceScore"]?.toDouble(),
        mainPic: json["mainPic"],
        tchaoshi: tChaoshi,
        id: json["id"] is String ? int.parse(json["id"]) : json["id"],
        brand: json["brand"],
        imgs: json["imgs"],
        brandName: json["brandName"],
        subcid: json["subcid"] != null
            ? List<int>.from(json["subcid"].map((x) => x))
            : null,
        couponConditions: json["couponConditions"],
        detailPics: json["detailPics"],
        subdivisionId: json["subdivisionId"],
        dsrScore: json["dsrScore"]?.toDouble(),
        shopLogo: json["shopLogo"],
        dailySales: json["dailySales"],
        shopLevel: json["shopLevel"].toString(),
        couponTotalNum: json["couponTotalNum"],
        descScore: json["descScore"]?.toDouble(),
        brandWenan: json["brandWenan"],
        activityEndTime: json["activityEndTime"],
        shipScore: json["shipScore"]?.toString(),
        brandId: json["brandId"] is String
            ? int.parse(json["brandId"])
            : json["brandId"],
        couponReceiveNum: json["couponReceiveNum"],
        shopType: json["shopType"],
        desc: json["desc"],
        cid: json["cid"],
        commissionRate: json["commissionRate"]?.toDouble(),
        originalPrice: json["originalPrice"]?.toDouble(),
        actualPrice: json["actualPrice"]?.toDouble(),
        goodsId: json["goodsId"],
        quanMLink: json["quanMLink"],
        shopName: json["shopName"],
        activityStartTime: json["activityStartTime"],
        video: json["video"],
        title: json["title"],
        dtitle: json["dtitle"],
        monthSales: json["monthSales"],
        subdivisionRank: json["subdivisionRank"],
        hzQuanOver: json["hzQuanOver"],
        isSubdivision: json["isSubdivision"],
        marketingMainPic: json["marketingMainPic"],
        directCommissionType: json["directCommissionType"],
        servicePercent: json["servicePercent"]?.toDouble(),
        commissionType: json["commissionType"],
        couponEndTime: json["couponEndTime"],
        directCommission: json["directCommission"]?.toDouble(),
        twoHoursSales: json["twoHoursSales"],
        createTime: '',
        dsrPercent: json["dsrPercent"]?.toDouble(),
        estimateAmount: json["estimateAmount"]?.toDouble(),
        specialText: json["specialText"] != null
            ? List<dynamic>.from(json["specialText"].map((x) => x))
            : [],
        couponPrice: json["couponPrice"]?.toDouble(),
        activityType: json["activityType"],
        hotPush: json["hotPush"],
        subdivisionName: json["subdivisionName"],
        circleText: json['circleText']);
  }

  factory Product.fromBrandDetailJson(Map<String, dynamic> json) {
    return Product(
        teamName: json["teamName"],
        tbcid:
        json["tbcid"] is String ? int.parse(json["tbcid"]) : json["tbcid"],
        shipPercent: json["shipPercent"]?.toDouble(),
        freeshipRemoteDistrict: json["freeshipRemoteDistrict"],
        yunfeixian: json["yunfeixian"],
        itemLink: json["itemLink"],
        goldSellers: json["goldSellers"],
        reimgs: json["reimgs"],
        couponLink: json["couponLink"],
        haitao: json["haitao"],
        sellerId: json["sellerId"],
        discounts: json["discount"]?.toDouble(),
        directCommissionLink: json["directCommissionLink"],
        couponStartTime: json["couponStartTime"],
        serviceScore: json["serviceScore"]?.toDouble(),
        mainPic: json["mainPic"],
        tchaoshi: json["tchaoshi"],
        id: json["id"] is String ? int.parse(json["id"]) : json["id"],
        brand: json["brand"],
        imgs: json["imgs"],
        brandName: json["brandName"],
        subcid: json["subcid"] != null
            ? List<int>.from(json["subcid"].map((x) => x))
            : null,
        couponConditions: json["couponConditions"],
        detailPics: json["detailPics"],
        subdivisionId: json["subdivisionId"],
        dsrScore: json["dsrScore"]?.toDouble(),
        shopLogo: json["shopLogo"],
        dailySales: json["dailySales"],
        shopLevel: json["shopLevel"].toString(),
        couponTotalNum: json["couponTotalNum"],
        descScore: json["descScore"]?.toDouble(),
        brandWenan: json["brandWenan"],
        activityEndTime: json["activityEndTime"],
        shipScore: json["shipScore"]?.toString(),
        brandId: json["brandId"] is String
            ? int.parse(json["brandId"])
            : json["brandId"],
        couponReceiveNum: json["couponReceiveNum"],
        shopType: json["shopType"],
        desc: json["desc"],
        cid: json["cid"],
        commissionRate: json["commissionRate"]?.toDouble(),
        originalPrice: json["originPrice"]?.toDouble(),
        actualPrice: json["actualPrice"]?.toDouble(),
        goodsId: json["goodsId"],
        quanMLink: json["quanMLink"],
        shopName: json["shopName"],
        activityStartTime: json["activityStartTime"],
        video: json["video"],
        title: json["title"],
        dtitle: json["dtitle"],
        monthSales: json["monthSales"],
        subdivisionRank: json["subdivisionRank"],
        hzQuanOver: json["hzQuanOver"],
        isSubdivision: json["isSubdivision"],
        marketingMainPic: json["marketingMainPic"],
        directCommissionType: json["directCommissionType"],
        servicePercent: json["servicePercent"]?.toDouble(),
        commissionType: json["commissionType"],
        couponEndTime: json["couponEndTime"],
        directCommission: json["directCommission"]?.toDouble(),
        twoHoursSales: json["twoHoursSales"],
        createTime: json["createTime"],
        dsrPercent: json["dsrPercent"]?.toDouble(),
        estimateAmount: json["estimateAmount"]?.toDouble(),
        specialText: json["specialText"] != null
            ? List<dynamic>.from(json["specialText"].map((x) => x))
            : [],
        couponPrice: json["couponPrice"]?.toDouble(),
        activityType: json["activityType"],
        hotPush: json["hotPush"],
        subdivisionName: json["subdivisionName"],
        circleText: json['circleText']);
  }

  Map<String, dynamic> toJson() => {
        "teamName": teamName,
        "tbcid": tbcid,
        "shipPercent": shipPercent,
        "freeshipRemoteDistrict": freeshipRemoteDistrict,
        "yunfeixian": yunfeixian,
        "itemLink": itemLink,
        "goldSellers": goldSellers,
        "reimgs": reimgs,
        "couponLink": couponLink,
        "haitao": haitao,
        "sellerId": sellerId,
        "discounts": discounts,
        "directCommissionLink": directCommissionLink,
        "couponStartTime": couponStartTime,
        "serviceScore": serviceScore,
        "mainPic": mainPic,
        "tchaoshi": tchaoshi,
        "id": id,
        "brand": brand,
        "imgs": imgs,
        "brandName": brandName,
        "subcid": jsonEncode(subcid),
        "couponConditions": couponConditions,
        "detailPics": detailPics,
        "subdivisionId": subdivisionId,
        "dsrScore": dsrScore,
        "shopLogo": shopLogo,
        "dailySales": dailySales,
        "shopLevel": shopLevel,
        "couponTotalNum": couponTotalNum,
        "descScore": descScore,
        "brandWenan": brandWenan,
        "activityEndTime": activityEndTime,
        "shipScore": shipScore,
        "brandId": brandId,
        "couponReceiveNum": couponReceiveNum,
        "shopType": shopType,
        "desc": desc,
        "cid": cid,
        "commissionRate": commissionRate,
        "originalPrice": originalPrice,
        "actualPrice": actualPrice,
        "goodsId": goodsId,
        "quanMLink": quanMLink,
        "shopName": shopName,
        "activityStartTime": activityStartTime,
        "video": video,
        "title": title,
        "dtitle": dtitle,
        "monthSales": monthSales,
        "subdivisionRank": subdivisionRank,
        "hzQuanOver": hzQuanOver,
        "isSubdivision": isSubdivision,
        "marketingMainPic": marketingMainPic,
        "directCommissionType": directCommissionType,
        "servicePercent": servicePercent,
        "commissionType": commissionType,
        "couponEndTime": couponEndTime,
        "directCommission": directCommission,
        "twoHoursSales": twoHoursSales,
        "createTime": createTime,
        "dsrPercent": dsrPercent,
        "estimateAmount": estimateAmount,
        "specialText": jsonEncode(specialText),
        "couponPrice": couponPrice,
        "activityType": activityType,
        "hotPush": hotPush,
        "subdivisionName": subdivisionName,
      };

  @override
  String getAmount() {
    return "$couponPrice";
  }

  @override
  String getArrivalPrice() {
    return "$actualPrice";
  }

  @override
  String getEndTime() {
    return "$couponEndTime";
  }

  @override
  String getImageUrl() {
    return "$mainPic";
  }

  @override
  String getProductId() {
    return "$goodsId";
  }

  @override
  String getTitle() {
    return "$title";
  }

  @override
  String getType() {
    return "淘宝";
  }
}
