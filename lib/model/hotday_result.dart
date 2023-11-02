// To parse this JSON data, do
//
//     final hotdayResult = hotdayResultFromJson(jsonString);

part of '../dataoke_sdk.dart';

HotdayResult hotdayResultFromJson(String str) => HotdayResult.fromJson(json.decode(str));

String hotdayResultToJson(HotdayResult data) => json.encode(data.toJson());

class HotdayResult {
  HotdayResult({
    this.totalNum,
    this.list,
    this.pageId,
  });

  int? totalNum;
  List<Product>? list;
  String? pageId;

  factory HotdayResult.fromJson(Map<String, dynamic> json) => HotdayResult(
    totalNum: json["totalNum"],
    list: List<Product>.from(json["list"].map(Product.fromJson)),
    pageId: json["pageId"],
  );

  Map<String, dynamic> toJson() => {
    "totalNum": totalNum,
    "list": jsonEncode(list),
    "pageId": pageId,
  };
}
