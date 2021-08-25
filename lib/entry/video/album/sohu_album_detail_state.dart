part of 'sohu_album_detail_bloc.dart';

@immutable
abstract class SohuAlbumDetailState {}

class SohuAlbumDetailInitial extends SohuAlbumDetailState {}

class SohuVideosLoadFinished extends SohuAlbumDetailState {
  PageCompletedState pageState;

  SohuVideosLoadFinished(this.pageState);
}

class SohuJumpToVideoPlay extends SohuAlbumDetailState {
  SohuVideoUrlData urlData;

  SohuJumpToVideoPlay(this.urlData);
}