// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

part of dataoke_sdk;

ProductListResult productListFromJson(String str) {
 try{
   return ProductListResult.fromJson(json.decode(str));
 }catch(e,s){
   debugPrintStack(stackTrace: s,label: 'model/product_list_result.dart:$e');
   throw AppException.appError();
 }
}
String productListToJson(ProductListResult data) => json.encode(data.toJson());

class ProductListResult {
  ProductListResult({
    this.goScroll,
    this.totalNum,
    this.list,
    this.pageId,
  });

  bool? goScroll;
  int? totalNum;
  List<Product>? list;
  String? pageId;

  factory ProductListResult.fromJson(Map<String, dynamic> json) => ProductListResult(
    goScroll: json["goScroll"],
    totalNum: json["totalNum"],
    list: List<Product>.from(json["list"].map((x) => Product.fromJson(x))),
    pageId: json["pageId"],
  );

  Map<String, dynamic> toJson() => {
    "goScroll": goScroll,
    "totalNum": totalNum,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
    "pageId": pageId,
  };
}
