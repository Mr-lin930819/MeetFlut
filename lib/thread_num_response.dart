import 'package:json_annotation/json_annotation.dart';

part 'thread_num_response.g.dart';

@JsonSerializable()
class ThreadNumResponse {
  ThreadNumResponse();
  String? status;
  ThreadNumData? data;

  factory ThreadNumResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreadNumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadNumResponseToJson(this);
}

@JsonSerializable()
class ThreadNumData {
  ThreadNumData();
  @JsonKey(ignore: true)
  bool loading = false;
  String? resultType;
  List<MetricResult?>? result;

  factory ThreadNumData.fromJson(Map<String, dynamic> json) =>
      _$ThreadNumDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadNumDataToJson(this);
}

@JsonSerializable()
class MetricResult {
  MetricResult();
  MetricData? metric;
  List<List<dynamic?>?>? values;

  factory MetricResult.fromJson(Map<String, dynamic> json) =>
      _$MetricResultFromJson(json);

  Map<String, dynamic> toJson() => _$MetricResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

@JsonSerializable()
class MetricData {
  MetricData();
  String? node;

  factory MetricData.fromJson(Map<String, dynamic> json) =>
      _$MetricDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetricDataToJson(this);
}



