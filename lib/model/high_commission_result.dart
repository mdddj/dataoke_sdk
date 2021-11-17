// To parse this JSON data, do
//
//     final HighCommissionResult = HighCommissionResultFromJson(jsonString);

import 'dart:convert';

import 'product.dart';

HighCommissionResult highCommissionResultFromJson(String str) =>
    HighCommissionResult.fromJson(json.decode(str));

String highCommissionResultToJson(HighCommissionResult data) =>
    json.encode(data.toJson());

class HighCommissionResult {
  HighCommissionResult({
    this.totalNum,
    this.list,
    this.pageId,
  });

  int? totalNum;
  List<Product>? list;
  String? pageId;

  factory HighCommissionResult.fromJson(Map<String, dynamic> json) =>
      HighCommissionResult(
        totalNum: json["totalNum"],
        list: List<Product>.from(json["list"].map((x) => Product.fromJson(x))),
        pageId: json["pageId"],
      );

  Map<String, dynamic> toJson() => {
        "totalNum": totalNum,
        "list": jsonEncode(list),
        "pageId": pageId,
      };
}
