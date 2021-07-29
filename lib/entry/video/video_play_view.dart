import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlayView> {
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.network('http://hot.vrs.sohu.com/ipad3669271_4603585256668_6870592.m3u8?plat=6uid=f5dbc7b40dad477c8516885f6c681c01&pt=5&prod=app&pg=1');
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Chewie(controller: _chewieController));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
