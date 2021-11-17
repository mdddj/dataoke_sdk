// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.cname,
    this.cpic,
    this.subcategories,
    this.cid,
  });

  String? cname;
  String? cpic;
  List<Subcategory>? subcategories;
  int? cid;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    cname: json["cname"],
    cpic: json["cpic"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
    cid: json["cid"],
  );

  Map<String, dynamic> toJson() => {
    "cname": cname,
    "cpic": cpic,
    "subcategories": List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "cid": cid,
  };
}

class Subcategory {
  Subcategory({
    this.subcid,
    this.scpic,
    this.subcname,
  });

  int? subcid;
  String? scpic;
  String? subcname;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    subcid: json["subcid"],
    scpic: json["scpic"],
    subcname: json["subcname"],
  );

  Map<String, dynamic> toJson() => {
    "subcid": subcid,
    "scpic": scpic,
    "subcname": subcname,
  };
}
