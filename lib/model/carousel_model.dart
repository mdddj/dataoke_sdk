// To parse this JSON data, do
//
//     final carousel = carouselFromJson(jsonString);

import 'dart:convert';

List<Carousel> carouselFromJson(String str) {
 try{
   return List<Carousel>.from(json.decode(str).map((x) => Carousel.fromJson(x)));
 }catch(_){

   return [];
 }
}

String carouselToJson(List<Carousel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carousel {
  Carousel({
    this.topicImage,
    this.activityId,
    this.topicId,
    this.sourceType,
    this.link,
    this.topicName,
  });

  String? topicImage;
  String? activityId;
  int? topicId;
  int? sourceType;
  String? link;
  String? topicName;

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
    topicImage: json["topicImage"],
    activityId: json["activityId"],
    topicId: json["topicId"],
    sourceType: json["sourceType"],
    link: json["link"],
    topicName: json["topicName"],
  );

  Map<String, dynamic> toJson() => {
    "topicImage": topicImage,
    "activityId": activityId,
    "topicId": topicId,
    "sourceType": sourceType,
    "link": link,
    "topicName": topicName,
  };
}
