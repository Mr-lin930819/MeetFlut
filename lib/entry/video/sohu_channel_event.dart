part of 'sohu_channel_bloc.dart';

@immutable
abstract class SohuChannelEvent {}

class SohuChannelRefreshEvent extends SohuChannelEvent {
  static final int SOHU_CHANNELID_MOVIE = 1; //搜狐电影频道ID
  static final int SOHU_CHANNELID_SERIES = 2; //搜狐电视剧频道ID
  static final int SOHU_CHANNELID_VARIETY = 7; //搜狐综艺频道ID
  static final int SOHU_CHANNELID_DOCUMENTRY = 8; //搜狐纪录片频道ID
  static final int SOHU_CHANNELID_COMIC = 16; //搜狐动漫频道ID
  static final int SOHU_CHANNELID_MUSIC = 24; //搜狐音乐频道ID
  String channelId;

  SohuChannelRefreshEvent([this.channelId = ""]) {
    if (channelId.isEmpty) {
      this.channelId = "${SohuChannelRefreshEvent.SOHU_CHANNELID_SERIES}";
    }
  }
}

class SohuChannelLoadMoreEvent extends SohuChannelEvent {}
