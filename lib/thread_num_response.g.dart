// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_num_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadNumResponse _$ThreadNumResponseFromJson(Map<String, dynamic> json) {
  return ThreadNumResponse()
    ..status = json['status'] as String?
    ..data = json['data'] == null
        ? null
        : ThreadNumData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ThreadNumResponseToJson(ThreadNumResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ThreadNumData _$ThreadNumDataFromJson(Map<String, dynamic> json) {
  return ThreadNumData()
    ..resultType = json['resultType'] as String?
    ..result = (json['result'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : MetricResult.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ThreadNumDataToJson(ThreadNumData instance) =>
    <String, dynamic>{
      'resultType': instance.resultType,
      'result': instance.result,
    };

MetricResult _$MetricResultFromJson(Map<String, dynamic> json) {
  return MetricResult()
    ..metric = json['metric'] == null
        ? null
        : MetricData.fromJson(json['metric'] as Map<String, dynamic>)
    ..values = (json['values'] as List<dynamic>?)
        ?.map((e) => e as List<dynamic>?)
        .toList();
}

Map<String, dynamic> _$MetricResultToJson(MetricResult instance) =>
    <String, dynamic>{
      'metric': instance.metric,
      'values': instance.values,
    };

MetricData _$MetricDataFromJson(Map<String, dynamic> json) {
  return MetricData()..node = json['node'] as String?;
}

Map<String, dynamic> _$MetricDataToJson(MetricData instance) =>
    <String, dynamic>{
      'node': instance.node,
    };
