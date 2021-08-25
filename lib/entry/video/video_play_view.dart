import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends StatefulWidget {
  final String videoUrl;

  VideoPlayView(this.videoUrl);

  @override
  State<StatefulWidget> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlayView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
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
