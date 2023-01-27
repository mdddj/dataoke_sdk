// To parse this JSON data, do
//
//     final brandListResult = brandListResultFromJson(jsonString);

part of dataoke_sdk;

BrandListResult brandListResultFromJson(String str) =>
    BrandListResult.fromJson(json.decode(str));

String brandListResultToJson(BrandListResult data) =>
    json.encode(data.toJson());

class BrandListResult {
  BrandListResult({
    this.lists,
    this.pageSize,
    this.currentPage,
    this.totalCount,
  });

  List<ListElement>? lists;
  int? pageSize;
  int? currentPage;
  int? totalCount;

  factory BrandListResult.fromJson(Map<String, dynamic> json) =>
      BrandListResult(
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
        pageSize: json["pageSize"],
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "lists": List<dynamic>.from(lists!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "currentPage": currentPage,
        "totalCount": totalCount,
      };
}

class ListElement {
  ListElement({
    this.brandName,
    this.brandId,
    this.maxDiscountAmount,
    this.goodsList,
    this.brandFeatures,
    this.brandLogo,
    this.sales,
    this.maxDiscount,
  });

  String? brandName;
  int? brandId;
  double? maxDiscountAmount;
  List<Product>? goodsList;
  String? brandFeatures;
  String? brandLogo;
  int? sales;
  double? maxDiscount;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        brandName: json["brandName"],
        brandId: json["brandId"],
        maxDiscountAmount: json["maxDiscountAmount"] is double
            ? json["maxDiscountAmount"]
            : json["maxDiscountAmount"].toDouble(),
        goodsList: List<Product>.from(
            json["goodsList"].map((x) => Product.fromJson(x))),
        brandFeatures: json["brandFeatures"],
        brandLogo: json["brandLogo"],
        sales: json["sales"],
        maxDiscount: json["maxDiscount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "brandName": brandName,
        "brandId": brandId,
        "maxDiscountAmount": maxDiscountAmount,
        "goodsList": jsonEncode(goodsList),
        "brandFeatures": brandFeatures,
        "brandLogo": brandLogo,
        "sales": sales,
        "maxDiscount": maxDiscount,
      };
}
