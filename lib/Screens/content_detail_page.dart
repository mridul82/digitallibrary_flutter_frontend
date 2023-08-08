import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/content.dart';
import '../models/content_details.dart';
import '../network_utils/api.dart';

class ContentDetailsPage extends StatefulWidget {
  final Contents content;
  const ContentDetailsPage({Key? key, required this.content}) : super(key: key);

  @override
  State<ContentDetailsPage> createState() => _ContentDetailsPageState();
}

class _ContentDetailsPageState extends State<ContentDetailsPage> {
  String? videoId;
  bool isFullScreen = false;
  YoutubePlayerController? _youtubeController;

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchVideoId();
  }

  Future<void> _fetchVideoId() async {
    try {
      ContentDetails contentDetails =
          await ContentDetailsService.getContentDetails(widget.content.id!);
      // Extract the video ID from the URL
      String? videoUrl = contentDetails.filename;
      print(videoUrl);
      if (videoUrl.isNotEmpty) {
        videoId = YoutubePlayer.convertUrlToId(videoUrl);
        setState(() {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              isLive: false,
              enableCaption: true,
              forceHD: false,
              controlsVisibleAtStart: true,
              hideThumbnail: true,
            ),
          );
        });
      }
    } catch (e) {
      print('Error fetching video ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Details'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Set a maximum height for the content based on the screen height
          double maxHeight = constraints.maxHeight * 2;
          return SingleChildScrollView(
            child: SizedBox(
              height: maxHeight,
              //padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_youtubeController != null)
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: YoutubePlayer(
                          controller: _youtubeController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        ),
                      ),
                    ),
                  Text(
                    widget.content.cntTitle ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.content.cntChapter ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Class: ${widget.content.cntClass ?? ''}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            onPressed: () {},
            child: const Icon(Icons.edit),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'delete',
            onPressed: () {},
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
