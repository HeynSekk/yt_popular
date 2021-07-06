import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_popular/models/videoData.dart';
import 'package:yt_popular/ui/common.dart';

class Player extends StatefulWidget {
  YtVideo vd;
  Player(this.vd);
  @override
  _PlayerState createState() => _PlayerState(vd);
}

class _PlayerState extends State<Player> {
  YtVideo vd;
  _PlayerState(this.vd);
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    //initialize controller
    _controller = YoutubePlayerController(
      initialVideoId: vd.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          //title
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        /*onEnded: (data) {
          _controller.load(this.url);
        },*/
      ),
      //BUILDER
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'YouTube Popular',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            player,
            Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: sw * 0.05, right: sw * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      DescTxt('Description', false),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: sw * 0.05),
                        child: Divider(),
                      ),
                      //title
                      LeadingTxt(vd.snippet.title, false),
                      SizedBox(height: 10),
                      //statistics
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          //like
                          Count(vd.statistics.likeCount, 'Likes'),
                          //views
                          Count(vd.statistics.viewCount, 'Views'),
                          //comment
                          Count(vd.statistics.commentCount, 'Comments'),
                          //dislike
                          Count(vd.statistics.likeCount, 'Dislikes'),
                          //fav
                          Count(vd.statistics.likeCount, 'Favs'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: sw * 0.05),
                        child: Divider(),
                      ),
                      //description
                      SelectableDescTxt(vd.snippet.description, false),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Count extends StatelessWidget {
  String countData, countType;

  Count(this.countData, this.countType);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          countData,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        SizedBox(height: 5),
        Text(
          countType,
          style: TextStyle(
            color: Color(0xff7a7a7a),
            fontSize: 13,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
