part of 'sohu_channel_bloc.dart';

@immutable
abstract class SohuChannelState {}

class SohuChannelInitial extends SohuChannelState {}

class SohuChannelLoading extends SohuChannelState {}

class SohuChannelLoadSuccess extends SohuChannelState {
  List<SohuAlbum> albumList;

  SohuChannelLoadSuccess(this.albumList);
}

class SohuChannelLoadFail extends SohuChannelState {}
