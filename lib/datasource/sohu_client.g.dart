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
  Future<SohuAlbumResult> getChannelAlbum(cid, page, pageSize,
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
        _setStreamType<SohuAlbumResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/search/channel.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SohuAlbumResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SohuAlbumDetailResult> getAlbumDetail(albumId,
      [plat = 6,
      poid = 1,
      apiKey = "9854b2afa779e1a6bff1962447a09dbd",
      sVer = "6.2.0",
      sysVer = "4.4.2",
      partner = 47]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'plat': plat,
      r'poid': poid,
      r'api_key': apiKey,
      r'sver': sVer,
      r'sysver': sysVer,
      r'partner': partner
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SohuAlbumDetailResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/album/info/$albumId.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SohuAlbumDetailResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SohuVideoResult> getVideo(albumId, page, pageSize,
      [order = 0,
      site = 1,
      withTrailer = 1,
      plat = 6,
      poid = 1,
      apiKey = "9854b2afa779e1a6bff1962447a09dbd",
      sVer = "6.2.0",
      sysVer = "4.4.2",
      partner = 47]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'page_size': pageSize,
      r'order': order,
      r'site': site,
      r'with_trailer': withTrailer,
      r'plat': plat,
      r'poid': poid,
      r'api_key': apiKey,
      r'sver': sVer,
      r'sysver': sysVer,
      r'partner': partner
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SohuVideoResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/album/videos/$albumId.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SohuVideoResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SohuVideoUrlResult> getVideoPlayUrl(vid, aid,
      [site = 1,
      plat = 6,
      poid = 1,
      apiKey = "9854b2afa779e1a6bff1962447a09dbd",
      sVer = "6.2.0",
      sysVer = "4.4.2",
      partner = 47]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'aid': aid,
      r'site': site,
      r'plat': plat,
      r'poid': poid,
      r'api_key': apiKey,
      r'sver': sVer,
      r'sysver': sysVer,
      r'partner': partner
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SohuVideoUrlResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/video/info/$vid.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SohuVideoUrlResult.fromJson(_result.data!);
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
