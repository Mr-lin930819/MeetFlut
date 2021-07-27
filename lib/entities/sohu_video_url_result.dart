import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'sohu_video_url_result.g.dart';

@JsonSerializable()
class SohuVideoUrlResult {
  SohuVideoUrlData data;

  SohuVideoUrlResult(this.data);

  factory SohuVideoUrlResult.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoUrlResultFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoUrlResultToJson(this);
}

@JsonSerializable()
class SohuVideoUrlData {
  @JsonKey(name: "url_nor")
  String urlNor;
  @JsonKey(name: "url_super")
  String urlSuper;
  @JsonKey(name: "url_high")
  String urlHigh;

  SohuVideoUrlData(this.urlNor, this.urlSuper, this.urlHigh);

  factory SohuVideoUrlData.fromJson(Map<String, dynamic> json) =>
      _$SohuVideoUrlDataFromJson(json);

  Map<String, dynamic> toJson() => _$SohuVideoUrlDataToJson(this);

  Uuid get _uuid => Uuid();

  String get normalUrl => "${urlNor}${_urlSuffix()}";

  String get superUrl => "${urlSuper}${_urlSuffix()}";

  String get highUrl => "${urlHigh}${_urlSuffix()}";

  String _urlSuffix() {
    return "uid=${_uuid.v4().replaceAll("-", "")}&pt=5&prod=app&pg=1";
  }
}
