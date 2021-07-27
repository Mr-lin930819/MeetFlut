class VideoChannel {
  static final int SOHU_CHANNELID_MOVIE = 1; //搜狐电影频道ID
  static final int SOHU_CHANNELID_SERIES = 2; //搜狐电视剧频道ID
  static final int SOHU_CHANNELID_VARIETY = 7; //搜狐综艺频道ID
  static final int SOHU_CHANNELID_DOCUMENTRY = 8; //搜狐纪录片频道ID
  static final int SOHU_CHANNELID_COMIC = 16; //搜狐动漫频道ID
  static final int SOHU_CHANNELID_MUSIC = 24; //搜狐音乐频道ID

  String title;
  int channelId;

  VideoChannel(this.title, this.channelId);
}
