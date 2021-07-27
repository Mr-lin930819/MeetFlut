// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sohu_video_url_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SohuVideoUrlResult _$SohuVideoUrlResultFromJson(Map<String, dynamic> json) {
  return SohuVideoUrlResult(
    SohuVideoUrlData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SohuVideoUrlResultToJson(SohuVideoUrlResult instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SohuVideoUrlData _$SohuVideoUrlDataFromJson(Map<String, dynamic> json) {
  return SohuVideoUrlData(
    json['url_nor'] as String,
    json['url_super'] as String,
    json['url_high'] as String,
  );
}

Map<String, dynamic> _$SohuVideoUrlDataToJson(SohuVideoUrlData instance) =>
    <String, dynamic>{
      'url_nor': instance.urlNor,
      'url_super': instance.urlSuper,
      'url_high': instance.urlHigh,
    };
