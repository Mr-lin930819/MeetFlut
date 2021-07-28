import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meet_flut/entities/sohu_album_result.dart';
import 'package:meet_flut/entities/sohu_video_result.dart';
import 'package:meet_flut/entry/page/page_state.dart';
import 'package:meet_flut/entry/video/album/sohu_album_detail_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoAlbumDetail extends StatelessWidget {
  final SohuAlbum _album;
  final RefreshController _videosRefreshController =
      RefreshController(initialRefresh: true);
  final SohuAlbumDetailBloc _albumDetailBloc = GetIt.I.get();

  VideoAlbumDetail(this._album);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_album.albumName ?? ""),
        ),
        body: Column(
          children: [
            SizedBox(
              child: _Header(_album),
              height: 200,
            ),
            Expanded(
              child: BlocBuilder<SohuAlbumDetailBloc, SohuAlbumDetailState>(
                buildWhen: (prevState, newState) {
                  if (newState is SohuVideosLoadFinished) {
                    return _videosRefreshController.handlePageState(newState.pageState);
                  }
                  return true;
                },
                builder: (context, state) => SmartRefresher(
                  controller: _videosRefreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => _albumDetailBloc
                      .add(SohuAlbumVideoRefresh(_album.albumId ?? 0)),
                  onLoading: () => _albumDetailBloc.add(SohuAlbumVideoLoadMore()),
                  child: _buildVideoList(state),
                ),
                bloc: _albumDetailBloc,
              ),
            )
          ],
        ),
      );

  Widget _buildVideoList(SohuAlbumDetailState state) {
    if (state is SohuVideosLoadFinished) {
      return _buildVideoListContent(state.pageState);
    } else {
      return Center(child: Text('无数据'));
    }
  }

  Widget _buildVideoListContent(PageCompletedState pageState) {
    if (pageState is PageSuccessState<SohuVideo>) {
      final videoList = pageState.list;
      return ListView.separated(
          itemBuilder: (_, index) {
            SohuVideo video = videoList[index];
            return ListTile(
              title: Text(video.videoName),
            );
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: videoList.length);
    } else {
      return Text("载入错误");
    }
  }
}

class _Header extends StatelessWidget {
  final SohuAlbum _album;

  _Header(this._album);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(image: CachedNetworkImageProvider(_album.verHighPic ?? "")),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _album.tvDesc ?? "",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  '导演：${_album.director}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text('主演：${_album.mainActor}',
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          )
        ],
      ),
    );
  }
}
