// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sohu_album_detail_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SohuAlbumDetailResult _$SohuAlbumDetailResultFromJson(
    Map<String, dynamic> json) {
  return SohuAlbumDetailResult(
    json['status'] as int,
    json['statusText'] as String,
    SohuAlbum.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SohuAlbumDetailResultToJson(
        SohuAlbumDetailResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusText': instance.statusText,
      'data': instance.data,
    };
