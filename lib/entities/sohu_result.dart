import 'package:json_annotation/json_annotation.dart';

part 'sohu_result.g.dart';

@JsonSerializable()
class SohuResult {
  int status;
  String statusText;
  SohuData data;

  SohuResult(this.status, this.statusText, this.data);

  factory SohuResult.fromJson(Map<String, dynamic> json) =>
      _$SohuResultFromJson(json);

  Map<String, dynamic> toJson() => _$SohuResultToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class SohuData {
  int count;
  @JsonKey(name: "videos")
  List<SohuAlbum> albumList;

  factory SohuData.fromJson(Map<String, dynamic> json) =>
      _$SohuDataFromJson(json);

  Map<String, dynamic> toJson() => _$SohuDataToJson(this);

  SohuData(this.count, this.albumList);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class SohuAlbum {
  @JsonKey(name: 'album_desc')
  String? tvDesc; // 专辑描述
  String? director; //导演

  @JsonKey(name: 'hor_high_pic')
  String? horHighPic; //横图url

  @JsonKey(name: 'ver_high_pic')
  String? verHighPic; //竖图url

  @JsonKey(name: 'main_actor')
  String? mainActor; //主演

  @JsonKey(name: "album_name")
  String? albumName; //专辑名字

  String? tip; //更新到xxx集、更新到xxx期

  @JsonKey(name: "aid")
  int? albumId; //专辑id

  @JsonKey(name: "latest_video_count")
  int lastVideoCount; //专辑最新更新的集数

  @JsonKey(name: "total_video_count")
  int totalVideoCount;

  SohuAlbum(
      this.tvDesc,
      this.director,
      this.horHighPic,
      this.verHighPic,
      this.mainActor,
      this.albumName,
      this.tip,
      this.albumId,
      this.lastVideoCount,
      this.totalVideoCount); //专辑总集数


  factory SohuAlbum.fromJson(Map<String, dynamic> json) =>
      _$SohuAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$SohuAlbumToJson(this);

  @override
  String toString() => toJson().toString();
}
