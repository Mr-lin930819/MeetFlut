import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meet_flut/entry/video/sohu_channel_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoCommonChannel extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电视剧"),
      ),
      body: BlocBuilder<SohuChannelBloc, SohuChannelState>(
        builder: (BuildContext context, state) {
          if (state is SohuChannelLoading) {
            return Center(
              child: Text("加载数据中..."),
            );
          } else if (state is SohuChannelLoadSuccess) {
            final albumList = state.albumList;
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () => context.read<SohuChannelBloc>().add(SohuChannelRefreshEvent()),
              onLoading: () => context.read<SohuChannelBloc>().add(SohuChannelLoadMoreEvent()),
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final album = albumList[index];
                  return ListTile(
                    title: Text(album.albumName ?? ""),
                    subtitle: Text(
                      album.tvDesc ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Image(
                      image: NetworkImage(album.verHighPic ?? ""),
                    ),
                  );
                },
                itemCount: albumList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            );
          } else if (state is SohuChannelLoadFail) {
            return Center(
              child: Text("载入错误"),
            );
          } else {
            return Text('');
          }
        },
        bloc: GetIt.I.get(),
      ),
    );
  }
}
