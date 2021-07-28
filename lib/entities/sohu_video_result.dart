import 'package:json_annotation/json_annotation.dart';

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
  String? title;
  int site;
  int aid;

  SohuVideo(this.vid, this.videoName, this.horHighPic, this.verHighPic,
      this.title, this.site, this.aid);

  factory SohuVideo.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoToJson(this);
}
