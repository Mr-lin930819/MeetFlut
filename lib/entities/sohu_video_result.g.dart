// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sohu_video_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SohuVideoResult _$SohuVideoResultFromJson(Map<String, dynamic> json) {
  return SohuVideoResult(
    json['status'] as int,
    json['statusText'] as String,
    SohuVideoData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SohuVideoResultToJson(SohuVideoResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusText': instance.statusText,
      'data': instance.data,
    };

SohuVideoData _$SohuVideoDataFromJson(Map<String, dynamic> json) {
  return SohuVideoData(
    json['count'] as int,
    (json['videos'] as List<dynamic>?)
        ?.map((e) => SohuVideo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SohuVideoDataToJson(SohuVideoData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'videos': instance.videos,
    };

SohuVideo _$SohuVideoFromJson(Map<String, dynamic> json) {
  return SohuVideo(
    json['vid'] as int,
    json['video_name'] as String,
    json['hor_high_pic'] as String,
    json['ver_high_pic'] as String,
    json['url_nor'] as String,
    json['url_super'] as String,
    json['url_high'] as String,
    json['title'] as String?,
    json['site'] as int,
    json['aid'] as int,
  );
}

Map<String, dynamic> _$SohuVideoToJson(SohuVideo instance) => <String, dynamic>{
      'vid': instance.vid,
      'video_name': instance.videoName,
      'hor_high_pic': instance.horHighPic,
      'ver_high_pic': instance.verHighPic,
      'url_nor': instance.urlNor,
      'url_super': instance.urlSuper,
      'url_high': instance.urlHigh,
      'title': instance.title,
      'site': instance.site,
      'aid': instance.aid,
    };
