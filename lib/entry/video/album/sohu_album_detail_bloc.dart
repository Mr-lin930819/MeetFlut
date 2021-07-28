import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meet_flut/datasource/sohu_client.dart';
import 'package:meet_flut/entities/sohu_video_result.dart';
import 'package:meet_flut/entry/page/page_handler.dart';
import 'package:meet_flut/entry/page/page_state.dart';
import 'package:meta/meta.dart';

part 'sohu_album_detail_event.dart';

part 'sohu_album_detail_state.dart';

@injectable
class SohuAlbumDetailBloc
    extends Bloc<SohuAlbumDetailEvent, SohuAlbumDetailState> {
  SohuClient _sohuClient;
  late PageHandler<SohuVideo, int> _pageHandler;
  static const int _PAGE_SIZE = 10;

  SohuAlbumDetailBloc(this._sohuClient) : super(SohuAlbumDetailInitial()) {
    _pageHandler =
        PageHandler((page, albumId) => _loadVideoList(albumId ?? 0, page));
  }

  @override
  Stream<SohuAlbumDetailState> mapEventToState(
    SohuAlbumDetailEvent event,
  ) async* {
    if (event is SohuAlbumVideoRefresh) {
      yield SohuVideosLoadFinished(await _pageHandler.refresh(event.albumId));
    } else if (event is SohuAlbumVideoLoadMore) {
      yield SohuVideosLoadFinished(await _pageHandler.loadMore());
    }
  }

  Future<List<SohuVideo>?> _loadVideoList(int albumId, int page) async {
    try {
      SohuVideoResult result =
          await _sohuClient.getVideo(albumId, page, _PAGE_SIZE);
      return result.data.videos ?? [];
    } on DioError catch (dioError) {
      throw PageFailException(dioError.message);
    }
  }
}
