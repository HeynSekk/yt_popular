import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yt_popular/models/videoData.dart';
import 'package:yt_popular/models/homeVdsList.dart';
import 'package:yt_popular/ui/player.dart';
import 'common.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<HomeVdsList>().loadVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeVdsList vl = context.watch<HomeVdsList>();
    final String r = vl.loadResult;
    if (r == '1') {
      //vd list
      return NormalFrameForScroll(VideosListUi());
    } else if (r == 'nf') {
      //circle
      return PlainFrame(MyProgressIndicator(''));
    } else {
      //err
      return PlainFrame(ErrorMessage(
        //lead, desc, icon, myan
        'Error',
        '$r',
        Icons.error,
        false,
      ));
    }
  }
}

class VideosListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVdsList vl = context.watch<HomeVdsList>();
    final List<YtVideo> videos = vl.vds;
    return ListView.builder(
      itemCount: videos.length + 2,
      itemBuilder: (BuildContext context, int i) {
        //first item
        if (i == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              LeadingTxt('  What\'s popular on Youtube?', false),
              SizedBox(height: 20),
            ],
          );
        }
        //last item
        else if (i == videos.length + 1) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Center(
              child: LoadMoreBtn(),
            ),
          );
        }

        //else, normal list item
        int index = i - 1;
        return YtVdItem(videos[index]);
      },
    );
  }
}

class YtVdItem extends StatelessWidget {
  final YtVideo ytVd;
  YtVdItem(this.ytVd);
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VdThumbnail(
              ytVd.snippet.thumbnails.high.url, ytVd.contentDetails.duration),
          SizedBox(height: 5),
          DescTxt('${ytVd.snippet.title}', false),
          SmallerDescTxt(
            '${ytVd.snippet.channelTitle} | ${ytVd.statistics.viewCount} views | ${ytVd.snippet.publishedAt}\n',
            false,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Player(ytVd),
          ),
        );
      },
    );
  }
}

class VdThumbnail extends StatelessWidget {
  final String url, duration;
  VdThumbnail(this.url, this.duration);
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        //image
        Image.network(
          url,
          width: sw,
          height: sw * 0.75,
        ),
        //duration
        Padding(
          padding: EdgeInsets.only(bottom: 5, right: 5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(1.5),
            ),
            child: Text(
              duration,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoadMoreBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVdsList vl = context.watch<HomeVdsList>();
    final String r = vl.nextPageLoadResult;
    //should show
    if (vl.nextPageToken != null) {
      //initial or loaded
      if (r == '1') {
        return InkWell(
          onTap: () async {
            vl.loadMoreVideos();
          },
          child: ActionButton(Icons.more_horiz, 'Load more videos'),
        );
      }
      //loading
      else if (r == 'l') {
        return MyProgressIndicator('Loading...');
      }
      //err
      else {
        return DescTxt('Error: $r', true);
      }
    }
    //no more videos
    else {
      return Text('');
    }
  }
}
