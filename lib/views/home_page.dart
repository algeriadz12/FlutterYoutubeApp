import 'package:flutter/material.dart';
import 'package:youtube_player/files/custom_sliver_app_bar.dart';
import 'package:youtube_player/files/video_card.dart';
import 'package:youtube_player/models/channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context,index){
                var video = videos[index];
                return VideoCard(video : video);
              },childCount: videos.length),
              ),
            ),
        ],
      ),
    );
  }
}
