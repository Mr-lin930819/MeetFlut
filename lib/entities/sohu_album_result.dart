import 'package:json_annotation/json_annotation.dart';

part 'sohu_album_result.g.dart';

@JsonSerializable()
class SohuAlbumResult {
  int status;
  String statusText;
  SohuAlbumData data;

  SohuAlbumResult(this.status, this.statusText, this.data);

  factory SohuAlbumResult.fromJson(Map<String, dynamic> json) =>
      _$SohuAlbumResultFromJson(json);

  Map<String, dynamic> toJson() => _$SohuAlbumResultToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class SohuAlbumData {
  int count;
  @JsonKey(name: "videos")
  List<SohuAlbum> albumList;

  factory SohuAlbumData.fromJson(Map<String, dynamic> json) =>
      _$SohuAlbumDataFromJson(json);

  Map<String, dynamic> toJson() => _$SohuAlbumDataToJson(this);

  SohuAlbumData(this.count, this.albumList);

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
