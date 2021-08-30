import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yt_popular/models/videoData.dart';
import 'package:yt_popular/models/homeVdsList.dart';
import 'common.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    //load tech vds
    context.read<HomeVdsList>().loadVideos(28);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NormalFrameForScroll(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //app bar
          AppBar(
            backgroundColor: Colors.red,
            title: Text(
              'YT Popular',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ],
          ),
          //vds list
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              child: VideosListUi(),
            ),
          ),
          //categ selector
          CategorySelector(),
        ],
      ),
    );
  }
}

class VideosListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVdsList vl = context.watch<HomeVdsList>();
    final String r = vl.loadResult;
    final List<YtVideo> videos = vl.vds;
    if (r == '1') {
      //vd list
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
                LeadingTxt('  What\'s popular on YouTube?', false),
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
    } else if (r == 'l') {
      //circle
      return Center(child: MyProgressIndicator(''));
    } else {
      //err
      return Center(
          child: ErrorMessage(
        //lead, desc, icon, myan
        'Error',
        '$r',
        Icons.error,
        false,
      ));
    }
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
            vl.loadMoreVideos(vl.currentVdCategoryId);
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

//sci and tech 28, musicc 10, Howto & Style=26,Education=27,Documentary=35,Family=37
class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeVdsList vl = context.watch<HomeVdsList>();
    final int categId = vl.currentVdCategoryId;
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 10, height: 0),
            CategoryChip(categId, 28, 'Science & Tech'),
            CategoryChip(categId, 10, 'Music'),
            CategoryChip(categId, 26, 'Howto & Style'),
            CategoryChip(categId, 27, 'Education'),
            //CategoryChip(categId, 35, 'Documentary'),
            //CategoryChip(categId, 37, 'Family'),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final int currentId;
  final int thisId;
  final String name;
  CategoryChip(this.currentId, this.thisId, this.name);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<HomeVdsList>().loadVideos(thisId);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(
            name,
            style: TextStyle(
                color: currentId == thisId ? Colors.white : Colors.black),
          ),
          backgroundColor: currentId == thisId ? Colors.red : Color(0xffe2b7b7),
        ),
      ),
    );
  }
}
