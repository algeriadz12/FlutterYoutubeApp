import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player/models/channel.dart';
import 'package:youtube_player/views/main_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends ConsumerWidget {
  late YoutubePlayerController _controller;
  VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedVideo  = ref.watch(videoStateProvider.notifier).state;
    _controller = YoutubePlayerController(
        initialVideoId: convertUrl(selectedVideo!.id),
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false
        ));
    return Scaffold(
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller,),
          builder: (context,player){
            return YoutubePlayer(controller: _controller);
          },
        ),
      ),
    );
  }

  String convertUrl(url){
    return YoutubePlayer.convertUrlToId(url).toString();
  }

}
