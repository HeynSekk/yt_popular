import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:yt_popular/models/apiServices.dart';
import 'package:yt_popular/models/videoData.dart';
import 'videoData.dart';
import 'package:dio/dio.dart';
import 'sensitiveData.dart';

class HomeVdsList extends ChangeNotifier {
  List<YtVideo> vds = [];
  String loadResult = 'nf';
  String nextPageLoadResult = '1'; //1=initial or loaded, l= loading, other=err
  String? nextPageToken;

  //load vds
  Future<void> loadVideos() async {
    //call api
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger()); //for logging
    final ApiServices client = new ApiServices(dio);
    ResponseData responseData = await client
        .fetchPopularVideos(
      "snippet%2CcontentDetails%2Cstatistics",
      "mostPopular",
      28,
      15,
      apiKey,
    )
        //if success
        .then((res) {
      loadResult = '1';
      return res;
    }).catchError((Object e) {
      if (e.runtimeType == DioError) {
        print('DIO ERR');
        loadResult =
            (e as DioError).response?.statusMessage ?? "Cannot fetch data";
      } else {
        loadResult =
            'Err in calling, API${e.runtimeType}\ndetail= ${e.toString()}';
      }
    });
    //if api success
    if (loadResult == '1') {
      //transform count to shorter form
      //add vds to list var
      vds = transformResponseVds(responseData.items);
      //check if next page
      nextPageToken = responseData.nextPageToken;
    }

    notifyListeners();
  }

  //load more vds
  Future<void> loadMoreVideos() async {
    this.nextPageLoadResult = 'l';
    notifyListeners();
    //call api with next page token
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger());
    final ApiServices client = new ApiServices(dio);
    ResponseData responseData = await client
        .fetchNextPagePopularVideos(
      this.nextPageToken!,
      "snippet%2CcontentDetails%2Cstatistics",
      "mostPopular",
      28,
      15,
      apiKey,
    )
        //if success
        .then((res) {
      nextPageLoadResult = '1';
      return res;
    }).catchError((Object e) {
      if (e.runtimeType == DioError) {
        print('DIO ERR');
        nextPageLoadResult =
            (e as DioError).response?.statusMessage ?? "Cannot fetch data";
      } else {
        nextPageLoadResult =
            'err in calling api\n${e.runtimeType}\ndetail= ${e.toString()}';
      }
    });
    //if api success
    if (nextPageLoadResult == '1') {
      //add vds to list var
      vds.addAll(transformResponseVds(responseData.items));
      //check if next page
      this.nextPageToken = responseData.nextPageToken;
    }

    notifyListeners();
  }

  //TRANSFORM VDS STATISTICS
  List<YtVideo> transformResponseVds(List<YtVideo> vds) {
    vds.forEach((vd) {
      //make count shorter
      vd.statistics.viewCount = shortenCount(vd.statistics.viewCount);
      vd.statistics.likeCount = shortenCount(vd.statistics.likeCount);
      vd.statistics.dislikeCount = shortenCount(vd.statistics.dislikeCount);
      vd.statistics.favouriteCount = shortenCount(vd.statistics.favouriteCount);
      vd.statistics.commentCount = shortenCount(vd.statistics.commentCount);
      //make duration readable
      vd.contentDetails.duration =
          getReadableDuration(vd.contentDetails.duration);
      //make date readable
      vd.snippet.publishedAt = getReadableDate(vd.snippet.publishedAt);
    });
    return vds;
  }

  //MAKE COUNT SHORT
  //transforming statistics count to short form like 1222 = 1.2K
  //I followed this difficult way cause dividing the count by 1 kilo/1M/1B and applying
  //toStringAsFixed() method cannot give correct result in the case like 9999 = 9.99K. It give incorrect result
  //9999= 10.00K
  String shortenCount(String count) {
    print(count);
    String decimal;
    String leading;
    int leadCount;
    //BILLION
    if (count.length > 9) {
      //get last 9 digits
      decimal = count.substring((count.length - 8) - 1);
      //decimal= first 2 digit from that
      decimal = decimal.substring(0, 2);
      //leading count= length of entire string-9
      leadCount = count.length - 9;
      //leading digit= substring(0,leading count)
      leading = count.substring(0, leadCount);
      //short form= leading digit + . + decimal
      print('$leading.$decimal B');
      return '$leading.$decimal B';
    }
    //MILLION
    else if (count.length > 6) {
      //get last 6 digits
      decimal = count.substring((count.length - 5) - 1);
      //decimal= first 2 digit from that
      decimal = decimal.substring(0, 2);
      //leading count= length of entire string-6
      leadCount = count.length - 6;
      //leading digit= substring(0,leading count)
      leading = count.substring(0, leadCount);
      //short form= leading digit + . + decimal
      print('$leading.$decimal M');
      return '$leading.$decimal M';
    }
    //KILO
    else if (count.length > 3) {
      //get last 3 digits
      decimal = count.substring((count.length - 2) - 1);
      //decimal= first digit from that
      decimal = decimal.substring(0, 1);
      //leading count= length of entire string-3
      leadCount = count.length - 3;
      //leading digit= substring(0,leading count)
      leading = count.substring(0, leadCount);
      //short form= leading digit + . + decimal
      print('$leading.$decimal K');
      return '$leading.$decimal K';
    }
    //NORMAL
    else {
      print('short form = $count');
      return count;
    }
  }

  String getReadableDate(String date) {
    return date.substring(0, 10);
  }

  String getReadableDuration(String isoData) {
    String r = '';
    //find matches and add to var
    RegExp(r"(\dH|\dM|\dS|\d\dH|\d\dM|\d\dS)").allMatches(isoData).forEach((m) {
      r = r + m[0]! + ':';
    });
    //remove : at last
    r = r.substring(0, (r.length - 1));
    //to lower case

    return r.toLowerCase();
    /*String str = 'PT4H3M27S';
    RegExp exp = RegExp(r"(\dH|\dM|\dS|\d\dH|\d\dM|\d\dS)");
    Iterable<Match> matches = exp.allMatches(str);
    print('matches lenght');
    print(matches.length);
    matches.forEach((m) {
      print(m[0]);
    });
    for (Match m in matches) {
      String match = m[0]!;
      print(match);
    }*/
  }
}
