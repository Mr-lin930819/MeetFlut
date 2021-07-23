import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meet_flut/entry/video/sohu_channel_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoCommonChannel extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final SohuChannelBloc _channelBloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电视剧"),
      ),
      body: BlocBuilder<SohuChannelBloc, SohuChannelState>(
        buildWhen: (prevState, newState) {
          if (newState is SohuChannelFail) {
            if (newState.isRefresh) {
              _refreshController.refreshFailed();
            } else {
              _refreshController.loadFailed();
            }
            return false;
          }
          if (newState is SohuChannelLoadSuccess) {
            if (newState.noMoreData) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            if (newState.isRefresh) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.loadComplete();
            }
          }
          return true;
        },
        builder: (BuildContext context, state) => SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          header: ClassicHeader(),
          onRefresh: () => _channelBloc.add(SohuChannelRefreshEvent()),
          onLoading: () => _channelBloc.add(SohuChannelLoadMoreEvent()),
          child: _buildChannelsContent(state),
        ),
        bloc: _channelBloc,
      ),
    );
  }

  //构建频道内容
  Widget _buildChannelsContent(SohuChannelState state) {
    if (state is SohuChannelInitial) {
      return Center(
        child: Text("无数据"),
      );
    } else if (state is SohuChannelLoadSuccess) {
      final albumList = state.albumList;
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3.0 / 4.0),
        itemBuilder: (_, index) {
          final album = albumList[index];
          return Stack(
            children: [
              Image(
                image: CachedNetworkImageProvider(album.verHighPic ?? ""),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      album.tvDesc ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      album.albumName ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        itemCount: albumList.length,
      );
    } else {
      return Text('');
    }
  }
}
