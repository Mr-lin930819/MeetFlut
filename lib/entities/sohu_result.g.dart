// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sohu_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SohuResult _$SohuResultFromJson(Map<String, dynamic> json) {
  return SohuResult(
    json['status'] as int,
    json['statusText'] as String,
    SohuData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SohuResultToJson(SohuResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusText': instance.statusText,
      'data': instance.data,
    };

SohuData _$SohuDataFromJson(Map<String, dynamic> json) {
  return SohuData(
    json['count'] as int,
    (json['videos'] as List<dynamic>)
        .map((e) => SohuAlbum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SohuDataToJson(SohuData instance) => <String, dynamic>{
      'count': instance.count,
      'videos': instance.albumList,
    };

SohuAlbum _$SohuAlbumFromJson(Map<String, dynamic> json) {
  return SohuAlbum(
    json['album_desc'] as String?,
    json['director'] as String?,
    json['hor_high_pic'] as String?,
    json['ver_high_pic'] as String?,
    json['main_actor'] as String?,
    json['album_name'] as String?,
    json['tip'] as String?,
    json['aid'] as int?,
    json['latest_video_count'] as int,
    json['total_video_count'] as int,
  );
}

Map<String, dynamic> _$SohuAlbumToJson(SohuAlbum instance) => <String, dynamic>{
      'album_desc': instance.tvDesc,
      'director': instance.director,
      'hor_high_pic': instance.horHighPic,
      'ver_high_pic': instance.verHighPic,
      'main_actor': instance.mainActor,
      'album_name': instance.albumName,
      'tip': instance.tip,
      'aid': instance.albumId,
      'latest_video_count': instance.lastVideoCount,
      'total_video_count': instance.totalVideoCount,
    };
