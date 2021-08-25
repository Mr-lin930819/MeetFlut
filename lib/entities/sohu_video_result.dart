import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'sohu_video_result.g.dart';

@JsonSerializable()
class SohuVideoResult {
  int status;
  String statusText;
  SohuVideoData data;

  SohuVideoResult(this.status, this.statusText, this.data);

  factory SohuVideoResult.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoResultToJson(this);
}

@JsonSerializable()
class SohuVideoData {
  int count;
  List<SohuVideo>? videos;

  SohuVideoData(this.count, this.videos);

  factory SohuVideoData.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoDataFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoDataToJson(this);
}

@JsonSerializable()
class SohuVideo {
  int vid;
  @JsonKey(name: "video_name")
  String videoName;
  @JsonKey(name: "hor_high_pic")
  String horHighPic;
  @JsonKey(name: "ver_high_pic")
  String verHighPic;
  @JsonKey(name: "url_nor")
  String urlNor;
  @JsonKey(name: "url_super")
  String urlSuper;
  @JsonKey(name: "url_high")
  String urlHigh;
  String? title;
  int site;
  int aid;


  SohuVideo(
      this.vid,
      this.videoName,
      this.horHighPic,
      this.verHighPic,
      this.urlNor,
      this.urlSuper,
      this.urlHigh,
      this.title,
      this.site,
      this.aid);

  factory SohuVideo.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoToJson(this);

  Uuid get _uuid => Uuid();

  String get normalUrl => "${urlNor}${_urlSuffix()}";

  String get superUrl => "${urlSuper}${_urlSuffix()}";

  String get highUrl => "${urlHigh}${_urlSuffix()}";

  String _urlSuffix() {
    return "uid=${_uuid.v4().replaceAll("-", "")}&pt=5&prod=app&pg=1";
  }
}
