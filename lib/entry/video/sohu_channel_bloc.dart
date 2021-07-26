import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meet_flut/datasource/sohu_client.dart';
import 'package:meet_flut/entities/sohu_result.dart';
import 'package:meet_flut/entry/page/page_handler.dart';
import 'package:meet_flut/entry/page/page_state.dart';
import 'package:meta/meta.dart';
export 'package:meet_flut/entry/page/page_state.dart' show RefreshControllerEx;

part 'sohu_channel_event.dart';

part 'sohu_channel_state.dart';

@injectable
class SohuChannelBloc extends Bloc<SohuChannelEvent, SohuChannelState> {
  static const int _PAGE_SIZE = 12;
  SohuClient _sohuClient;

  late PageHandler<SohuAlbum, String> _pager;

  SohuChannelBloc(this._sohuClient) : super(SohuChannelInitial()) {
    _pager = PageHandler((page, channelId) => _loadAlbumList(page, channelId ?? ""));
  }

  @override
  Stream<SohuChannelState> mapEventToState(
    SohuChannelEvent event,
  ) async* {
    if (event is SohuChannelRefreshEvent) {
      yield SohuChannelCompleted(await _pager.refresh(event.channelId));
    } else if (event is SohuChannelLoadMoreEvent) {
      yield SohuChannelCompleted(await _pager.loadMore());
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
