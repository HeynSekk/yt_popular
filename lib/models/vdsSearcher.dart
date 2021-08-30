import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:yt_popular/models/apiServices.dart';
import 'package:yt_popular/models/responseTransformer.dart';
import 'package:yt_popular/models/videoData.dart';
import 'videoData.dart';
import 'package:dio/dio.dart';
import 'sensitiveData.dart';

class VdsSearcher extends ChangeNotifier {
  List<YtVideo> vds = [];
  String loadResult = '1';
  String loadMoreResult = '1'; //1=initial or loaded, l= loading, other=err
  String? nextPageToken;
  String keyword = '';

  //search vds
  /*
  High level explanation

  - Do first api call (search by keyword)
  - Two possibilities: api call success & api call error. 
  For success, two possibilities: videos exist (lenght of items field in the api response is greater than 0)
  & videos don't exist (lenght is equal to 0).
  For the first possibility, do second api call (fetch detail data about videos using video id).
  For the second possibility, just inform 'no search result' and do nothing
  */
  Future<void> searchVideos(String keywordToSearch) async {
    //change app state (loading and current vd categ id)
    loadResult = 'l';
    notifyListeners();

    // format the keyword for placing in the URI (space must be + in URI)
    print('raw keyword= $keywordToSearch');
    keyword = keywordToSearch.replaceAll(RegExp(r' '), '+');
    print('FORMATTED KEYWORD= $keyword');

    // first api call (search)
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger()); //for logging
    final ApiServices client = new ApiServices(dio);
    SearchResult searchResult = await client
        .searchByKeyword("snippet", 20, keyword, apiKey, "video")
        .then((res) {
      print('YAYY SEARCH SUCCESS!!!');
      //check if no search result
      if (res.items?.length == 0) {
        loadResult = 'nsr'; //no search result
      } else {
        loadResult = '1';
      }
      print('GONNA RETURN RES TO VAR');
      return res;
    }).catchError((Object e) {
      if (e.runtimeType == DioError) {
        print('DIO ERR');
        loadResult =
            (e as DioError).response?.statusMessage ?? "Cannot fetch data";
      } else {
        loadResult =
            'Err in calling API (search)\n${e.runtimeType}\ndetail= ${e.toString()}';
      }
      //return plain
      return SearchResult(items: [], nextPageToken: null);
    });

    //if first api call success

    if (loadResult == '1') {
      //assign next page token
      nextPageToken = searchResult.nextPageToken;
      // build ids list
      /*String ids = '';
      String temp = '';
      searchResult.items?.forEach((item) {
        temp = item.id?.videoId ?? 'no';
        if (temp != 'no') {
          ids = ids + temp + ',';
        }
      });*/
      String ids = '';
      searchResult.items?.forEach((item) {
        ids = ids + item.id.videoId + ',';
      });
      //remove , at the last
      ids = ids.substring(0, ids.length - 1);
      print('BUILT ID LIST= $ids');

      // fetch mul id videos (2nd calling api)

      FetchMultiVdsResult fmvr = await client
          .fetchMultipleVideos(
        "snippet,contentDetails,statistics",
        ids,
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
              'Err in calling API (multi vds)\n${e.runtimeType}\ndetail= ${e.toString()}';
        }
        return FetchMultiVdsResult(items: null);
      });

      //if second api call success
      if (loadResult == '1') {
        //transform vds, change status, add to var
        vds = ResponseTransformer().transformResponseVds(fmvr.items ?? []);
      }
    }
    notifyListeners();
  }

  //search more videos

  Future<void> searchMoreVideos() async {
    //change app state (loading and current vd categ id)
    loadMoreResult = 'l';
    notifyListeners();
    // call api (search)
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger()); //for logging
    final ApiServices client = new ApiServices(dio);
    SearchResult searchResult = await client
        .searchMoreByKeyword(
            this.nextPageToken!, "snippet", 20, keyword, apiKey, "video")
        //if success
        .then((res) {
      //check if no more videos
      if (res.items?.length == 0) {
        loadMoreResult = 'nmv'; //no more videos
      } else {
        loadMoreResult = '1';
      }
      return res;
    }).catchError((Object e) {
      if (e.runtimeType == DioError) {
        print('DIO ERR');
        loadMoreResult =
            (e as DioError).response?.statusMessage ?? "Cannot fetch data";
      } else {
        loadMoreResult =
            'Could not call the API (search)\n${e.runtimeType}\ndetail= ${e.toString()}';
      }
      return SearchResult(items: [], nextPageToken: null);
    });

    //if first api call success

    if (loadMoreResult == '1') {
      //assign next page token
      nextPageToken = searchResult.nextPageToken;
      // build ids list
      String ids = '';
      searchResult.items?.forEach((item) {
        ids = ids + item.id.videoId + ',';
      });
      //remove , at the last
      ids = ids.substring(0, ids.length - 1);

      // fetch mul id videos (2nd calling api)

      FetchMultiVdsResult fmvr = await client
          .fetchMultipleVideos(
        "snippet,contentDetails,statistics",
        ids,
        apiKey,
      )
          //if success
          .then((res) {
        loadMoreResult = '1';
        return res;
      }).catchError((Object e) {
        if (e.runtimeType == DioError) {
          print('DIO ERR');
          loadMoreResult =
              (e as DioError).response?.statusMessage ?? "Cannot fetch data";
        } else {
          loadMoreResult =
              'Err in calling API (multi vds)\n${e.runtimeType}\ndetail= ${e.toString()}';
        }
        return FetchMultiVdsResult(items: null);
      });

      //if second api call success
      if (loadMoreResult == '1') {
        //transform vds, change status, add to var
        vds.addAll(
            ResponseTransformer().transformResponseVds(fmvr.items ?? []));
      }
    }
    notifyListeners();
  }
}
