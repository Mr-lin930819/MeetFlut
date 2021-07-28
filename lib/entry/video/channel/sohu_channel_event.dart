part of 'sohu_channel_bloc.dart';

@immutable
abstract class SohuChannelEvent {}

class SohuChannelRefreshEvent extends SohuChannelEvent {
  String channelId;

  SohuChannelRefreshEvent([this.channelId = ""]) {
    if (channelId.isEmpty) {
      this.channelId = "${VideoChannel.SOHU_CHANNELID_SERIES}";
    }
  }
}

class SohuChannelLoadMoreEvent extends SohuChannelEvent {}
