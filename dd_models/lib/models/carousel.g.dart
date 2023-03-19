// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Carousel _$$_CarouselFromJson(Map<String, dynamic> json) => _$_Carousel(
      topicImage: json['topicImage'] as String? ?? '',
      activityId: json['activityId'] as String? ?? '',
      topicId: json['topicId'] as int? ?? 0,
      sourceType: json['sourceType'] as int? ?? 0,
      link: json['link'] as String? ?? '',
      topicName: json['topicName'] as String? ?? '',
    );

Map<String, dynamic> _$$_CarouselToJson(_$_Carousel instance) =>
    <String, dynamic>{
      'topicImage': instance.topicImage,
      'activityId': instance.activityId,
      'topicId': instance.topicId,
      'sourceType': instance.sourceType,
      'link': instance.link,
      'topicName': instance.topicName,
    };
