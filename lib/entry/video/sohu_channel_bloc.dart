import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meet_flut/datasource/sohu_client.dart';
import 'package:meet_flut/entities/sohu_result.dart';
import 'package:meta/meta.dart';

part 'sohu_channel_event.dart';

part 'sohu_channel_state.dart';

@injectable
class SohuChannelBloc extends Bloc<SohuChannelEvent, SohuChannelState> {
  static const int _PAGE_SIZE = 12;
  SohuClient _sohuClient;
  String _lastRefreshChannelId = "";
  List<SohuAlbum> _cachedAlbumList = [];
  int _curPage = 1;

  SohuChannelBloc(this._sohuClient) : super(SohuChannelInitial());

  @override
  Stream<SohuChannelState> mapEventToState(
    SohuChannelEvent event,
  ) async* {
    if (event is SohuChannelRefreshEvent) {
      final albumList = await _loadAlbumList(1, event.channelId);
      if (albumList != null) {
        _curPage = 2;
        _lastRefreshChannelId = event.channelId;
        _cachedAlbumList = albumList;
        yield SohuChannelLoadSuccess(albumList);
      } else {
        yield SohuChannelFail(true);
      }
    } else if (event is SohuChannelLoadMoreEvent) {
      final albumList = await _loadAlbumList(_curPage, _lastRefreshChannelId);
      if (albumList != null) {
        _curPage++;
        _cachedAlbumList.addAll(albumList);
        yield SohuChannelLoadSuccess(_cachedAlbumList, isRefresh: false);
      } else {
        yield SohuChannelFail(false);
      }
    }
  }

  Future<List<SohuAlbum>?> _loadAlbumList(int page, String channelId) async {
    try {
      SohuResult result =
          await _sohuClient.getChannelAlbum(channelId, page, _PAGE_SIZE);
      return result.data.albumList;
    } on DioError catch (dioError) {
      print(dioError.message);
      return null;
    }
  }
}
