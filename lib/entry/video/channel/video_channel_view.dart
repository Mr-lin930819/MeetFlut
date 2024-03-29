import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meet_flut/entities/sohu_album_result.dart';
import 'package:meet_flut/entities/video_channel.dart';
import 'package:meet_flut/entry/page/page_state.dart';
import 'package:meet_flut/entry/video/channel/sohu_channel_bloc.dart';
import 'package:meet_flut/named_routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoChannelView extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final SohuChannelBloc _channelBloc = GetIt.I.get();
  final VideoChannel? _videoChannel;

  VideoChannelView([this._videoChannel]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_videoChannel?.title ?? "电视剧"),
      ),
      body: BlocBuilder<SohuChannelBloc, SohuChannelState>(
        buildWhen: (prevState, newState) {
          if (newState is SohuChannelCompleted) {
            return _refreshController.handlePageState(newState.pageState);
          }
          return true;
        },
        builder: (BuildContext context, state) => SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          header: ClassicHeader(),
          onRefresh: () => _channelBloc.add(SohuChannelRefreshEvent(
              _videoChannel?.channelId.toString() ?? "")),
          onLoading: () => _channelBloc.add(SohuChannelLoadMoreEvent()),
          child: _buildChannelView(context, state),
        ),
        bloc: _channelBloc,
      ),
    );
  }

  //频道页界面
  Widget _buildChannelView(BuildContext context, SohuChannelState state) {
    if (state is SohuChannelInitial) {
      return Center(
        child: Text("无数据"),
      );
    } else if (state is SohuChannelCompleted) {
      return _buildChannelsContent(context, state.pageState);
    } else {
      return Text('');
    }
  }

  //构建频道内容
  Widget _buildChannelsContent(BuildContext context, PageCompletedState state) {
    if (state is PageSuccessState<SohuAlbum>) {
      final albumList = state.list;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3.0 / 4.0),
        itemBuilder: (_, index) {
          final album = albumList[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, NamedRoutes.VIDEO_ALBUM_DETAIL,
                arguments: {'album': album}),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image:
                            CachedNetworkImageProvider(album.verHighPic ?? ""),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          album.tvDesc ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  album.albumName ?? "",
                ),
              ],
            ),
          );
        },
        itemCount: albumList.length,
      );
    } else {
      return Text('');
    }
  }
}
