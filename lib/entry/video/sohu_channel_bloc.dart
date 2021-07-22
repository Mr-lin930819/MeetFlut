import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meet_flut/datasource/sohu_client.dart';
import 'package:meet_flut/entities/sohu_result.dart';
import 'package:meta/meta.dart';

part 'sohu_channel_event.dart';

part 'sohu_channel_state.dart';

@injectable
class SohuChannelBloc extends Bloc<SohuChannelEvent, SohuChannelState> {
  SohuClient _sohuClient;

  SohuChannelBloc(this._sohuClient) : super(SohuChannelInitial()) {
    add(SohuChannelRefreshEvent(
        "${SohuChannelRefreshEvent.SOHU_CHANNELID_SERIES}"));
  }

  @override
  Stream<SohuChannelState> mapEventToState(
    SohuChannelEvent event,
  ) async* {
    if (event is SohuChannelRefreshEvent) {
      yield SohuChannelLoading();
      final albumList = await _loadAlbumList(event.channelId);
      if (albumList != null) {
        yield SohuChannelLoadSuccess(albumList);
      } else {
        yield SohuChannelLoadFail();
      }
    } else if (event is SohuChannelLoadMoreEvent) {

    }
  }

  Future<List<SohuAlbum>?> _loadAlbumList(String channelId) async {
    SohuResult result = await _sohuClient.getChannelAlbum(channelId, 1, 30);
    return result.data.albumList;
  }
}
