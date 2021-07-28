part of 'sohu_channel_bloc.dart';

@immutable
abstract class SohuChannelState {}

class SohuChannelInitial extends SohuChannelState {}

class SohuChannelCompleted extends SohuChannelState {
  final PageCompletedState pageState;

  SohuChannelCompleted(this.pageState);
}
