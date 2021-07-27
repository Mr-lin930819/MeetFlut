import 'package:json_annotation/json_annotation.dart';
import 'package:meet_flut/entities/sohu_album_result.dart';

part 'sohu_album_detail_result.g.dart';

@JsonSerializable()
class SohuAlbumDetailResult {
  int status;
  String statusText;
  SohuAlbum data;

  SohuAlbumDetailResult(this.status, this.statusText, this.data);

  factory SohuAlbumDetailResult.fromJson(Map<String, dynamic> json) =>
      _$SohuAlbumDetailResultFromJson(json);

  Map<String, dynamic> toJson() => _$SohuAlbumDetailResultToJson(this);
}