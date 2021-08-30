import 'package:yt_popular/models/videoData.dart';

class ResponseTransformer {
  //TRANSFORM VDS STATISTICS
  List<YtVideo> transformResponseVds(List<YtVideo> vds) {
    vds.forEach((vd) {
      //make count shorter
      vd.statistics?.viewCount = shortenCount(vd.statistics?.viewCount ?? '0');
      vd.statistics?.likeCount = shortenCount(vd.statistics?.likeCount ?? '0');
      vd.statistics?.dislikeCount =
          shortenCount(vd.statistics?.dislikeCount ?? '0');
      vd.statistics?.favoriteCount =
          shortenCount(vd.statistics?.favoriteCount ?? '0');
      vd.statistics?.commentCount =
          shortenCount(vd.statistics?.commentCount ?? '0');
      //make duration readable
      vd.contentDetails?.duration =
          getReadableDuration(vd.contentDetails?.duration ?? 'PT0M0S');
      //make date readable
      vd.snippet?.publishedAt =
          getReadableDate(vd.snippet?.publishedAt ?? '0000-00-00T00:00:09Z');
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
    print('GONNA TRANSFORM $isoData to READABLE DURATION');
    String r = '';
    //extract data hour, minute, etc and add to var
    RegExp(r"(\dH|\d\dH|\dM|\d\dM|\dS|\d\dS)").allMatches(isoData).forEach((m) {
      r = r + m[0]! + ':';
    });
    print('DURATION WITH : = $r');
    //if could extract data
    if (r.length > 0) {
      //remove : at last
      r = r.substring(0, (r.length - 1));
      print(r);
      //to lower case
      return r.toLowerCase();
    }
    //if could not extract, just return lower case of the input
    else {
      return isoData.toLowerCase();
    }
  }
}
