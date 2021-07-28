part of 'sohu_album_detail_bloc.dart';

@immutable
abstract class SohuAlbumDetailEvent {}

class SohuAlbumVideoRefresh extends SohuAlbumDetailEvent {
  int albumId;

  SohuAlbumVideoRefresh(this.albumId);
}

class SohuAlbumVideoLoadMore extends SohuAlbumDetailEvent {}
