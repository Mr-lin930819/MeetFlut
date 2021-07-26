// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sohu_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SohuClient implements SohuClient {
  _SohuClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.tv.sohu.com/v4/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SohuResult> getChannelAlbum(cid, page, pageSize,
      [o = 1,
      plat = 6,
      poid = 1,
      apiKey = "9854b2afa779e1a6bff1962447a09dbd",
      sVer = "6.2.0",
      sysVer = "4.4.2",
      partner = 47]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cid': cid,
      r'page': page,
      r'page_size': pageSize,
      r'o': o,
      r'plat': plat,
      r'poid': poid,
      r'api_key': apiKey,
      r'sver': sVer,
      r'sysver': sysVer,
      r'partner': partner
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SohuResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/search/channel.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SohuResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
