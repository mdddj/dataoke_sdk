// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);



import 'dart:convert';

import 'package:hive/hive.dart';

part 'category.g.dart';




List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map(Category.fromJson));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 100)
class Category {
  Category({
    required this.cname,
    required this.cpic,
    required this.subcategories,
    required this.cid,
  });

  @HiveField(0)
  String cname;
  @HiveField(1)
  String cpic;
  @HiveField(2)
  List<Subcategory> subcategories;
  @HiveField(3)
  int cid;

  factory Category.fromJson(dynamic json) => Category(
    cname: json["cname"],
    cpic: json["cpic"],
    subcategories: List<Subcategory>.from(json["subcategories"].map(Subcategory.fromJson)),
    cid: json["cid"],
  );

  Map<String, dynamic> toJson() => {
    "cname": cname,
    "cpic": cpic,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    "cid": cid,
  };
}

@HiveType(typeId: 101)
class Subcategory {
  Subcategory({
    required this.subcid,
    required this.scpic,
    required this.subcname,
  });

  @HiveField(0)
  int subcid;
  @HiveField(1)
  String scpic;
  @HiveField(2)
  String subcname;

  factory Subcategory.fromJson(dynamic json) => Subcategory(
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

@HiveType(typeId: 102)
class CategoryWrapper {
  @HiveField(0)
  final List<Category> categorys;
  CategoryWrapper(this.categorys);

}
