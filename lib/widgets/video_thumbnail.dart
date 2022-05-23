import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatefulWidget {
  final String path;

  VideoThumbnail({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail>
    with AutomaticKeepAliveClientMixin {
  String thumb = '';
  bool loading = true;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            loading = false;
          }); //when your thumbnail will show.
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? Image.asset(
            'assets/images/video-placeholder.png',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )
        : VideoPlayer(_controller);
  }

  @override
  bool get wantKeepAlive => true;
}
