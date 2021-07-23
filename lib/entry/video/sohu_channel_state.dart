part of 'sohu_channel_bloc.dart';

@immutable
abstract class SohuChannelState {}

class SohuChannelInitial extends SohuChannelState {}

abstract class SohuChannelCompleted extends SohuChannelState {
  final bool isRefresh;

  SohuChannelCompleted(this.isRefresh);
}

class SohuChannelLoadSuccess extends SohuChannelCompleted {
  final List<SohuAlbum> albumList;
  final bool noMoreData;

  SohuChannelLoadSuccess(this.albumList,
      {bool isRefresh = true, this.noMoreData = false})
      : super(isRefresh);
}

class SohuChannelFail extends SohuChannelCompleted {
  SohuChannelFail(bool isRefresh) : super(isRefresh);
}
