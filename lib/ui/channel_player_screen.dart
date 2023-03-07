import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:live_tv/models/channel.dart';


class ChannelPlayerScreen extends StatefulWidget {
  final Channel channel;
  final String url;

  const ChannelPlayerScreen({Key? key, required this.channel, required this.url})
      : super(key: key);

  @override
  _ChannelPlayerScreenState createState() => _ChannelPlayerScreenState();
}

class _ChannelPlayerScreenState extends State<ChannelPlayerScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel.name),
      ),
      body:  YoYoPlayer(
        aspectRatio: 16 / 9,
        url: widget.url.toString(),
        videoStyle: VideoStyle(),
        videoLoadingStyle: VideoLoadingStyle(),
      ),
    );
  }
}
