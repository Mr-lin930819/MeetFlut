import 'package:json_annotation/json_annotation.dart';

part 'apm_charts_data.g.dart';

@JsonSerializable()
class ChartsResponse {
  ChartsResponse();
  String? status;
  ApmChartsData? data;

  factory ChartsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartsResponseToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class ApmChartsData {
  ApmChartsData();
  @JsonKey(ignore: true)
  bool loading = false;
  String? resultType;
  List<MetricResult?>? result;

  factory ApmChartsData.fromJson(Map<String, dynamic> json) =>
      _$ApmChartsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApmChartsDataToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class MetricResult {
  MetricResult();
  MetricData? metric;
  List<List<dynamic>?>? values;

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



