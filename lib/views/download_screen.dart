import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool _isDownloading = false;
  var progress = 0.0;
  final TextEditingController _urlController = TextEditingController();
  String videoId = '';
  String title = '';
  String publishDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextField(
                controller: _urlController,
                onChanged: (val){
                  getVideoInfo(val);
                },
                decoration: const InputDecoration(
                  hintText: 'Paste Url',
                  hintStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
            Image.network('https://img.youtube.com/vi/$videoId/0.jpg',height: 250,),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(publishDate),
            ),
            const SizedBox(height: 30,),
            TextButton.icon(
                onPressed: (){
                  downloadVideo(_urlController.text,context);
                },
                icon: const Icon(Icons.download),
                label: const Text("Start Download"),),
            const SizedBox(height: 50,),
            _isDownloading ?  Padding(
              padding:  const EdgeInsets.all(8.0),
              child:  LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.blueAccent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green)
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  getVideoInfo(url) async {
    var youtubeInfo  = YoutubeExplode();
    var video = await youtubeInfo.videos.get(url);
    setState(() {
      videoId = video.id.toString();
      title = video.title;
      publishDate = video.publishDate.toString();
    });
  }
  downloadVideo(url,context) async {
     var permission = await Permission.storage.request();
     if(permission.isGranted){
       // download video
       if(_urlController.text != ''){
         setState(() => _isDownloading = true);
         setState(() => progress = 0.0);
          var youtubeExplode = YoutubeExplode();
          var video = await youtubeExplode.videos.get(url);
          var manifest =  await youtubeExplode.videos.streamsClient.getManifest(url);
          var streams = manifest.muxed.withHighestBitrate();
          var audio = streams;
          var audioStream = youtubeExplode.videos.streamsClient.get(audio);

          // create directory
         Directory appDocDir = await getApplicationDocumentsDirectory();
         var appDocPath = appDocDir.path;
         var file = File(appDocPath + video.id.toString());

          //delete file if exists
          if (file.existsSync()) {
            file.deleteSync();
          }
          var output = file.openWrite(mode: FileMode.writeOnlyAppend);
          var size = audio.size.totalBytes;
          var count = 0;

          await for (final data in audioStream) {
            // Keep track of the current downloaded data.
            count += data.length;
            // Calculate the current progress.
            double val = ((count / size));
            var msg = '${video.title} Downloaded to $appDocPath/${video.id}';
            for (val; val == 1.0; val++) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));
            }
            setState(() => progress = val);

            // Write to file.
            output.add(data);
          }
       } else {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add url')));
         setState(() => _isDownloading = false);
       }
     } else {
       await Permission.storage.request();
     }
  }
}
