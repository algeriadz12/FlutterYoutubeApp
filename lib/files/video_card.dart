import 'package:flutter/material.dart';
import 'package:youtube_player/files/video_screen.dart';
import 'package:youtube_player/models/channel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_player/views/main_page.dart';

class VideoCard extends ConsumerWidget {
  final Video video;
  const VideoCard({Key? key,required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    return Column(
      children:  [
        Stack(
          children: [
            Image.network(video.thumbnailUrl,height: 220.0,
              width: double.infinity,fit: BoxFit.cover,),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.black,
                child: Text(video.duration,
                style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: (){
               //context.read(videoStateProvider).state = video;
               ref.read(videoStateProvider.notifier).state = video;
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  VideoScreen()));
            },
            child: Row(
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(video.channel.channelImageUrl),
                ),
                const SizedBox(width: 30,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text(video.title)),
                    Flexible(child: Text("${video.channel.channelName} | ${video.viewCount} | ${timeago.format(video.timestamp)}"))
                  ],
                ),),
                const Icon(Icons.more_vert,color: Colors.white,size: 20,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
