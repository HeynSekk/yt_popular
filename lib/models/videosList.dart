import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:yt_popular/models/apiServices.dart';
import 'package:yt_popular/models/videoData.dart';
import 'videoData.dart';
import 'package:dio/dio.dart';
import 'sensitiveData.dart';

class VideosList extends ChangeNotifier {
  List<YtVideo> musicVideos = [];
  List<YtVideo> techVideos = [];
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
      "snippet",
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
        loadResult = (e as DioError).response?.statusMessage ?? "ddd";
      } else {
        loadResult = '${e.runtimeType}\ndetail= ${e.toString()}';
      }
    });
    //if api success
    if (loadResult == '1') {
      //add vds to list var
      musicVideos = responseData.items;
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
      "snippet",
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
        nextPageLoadResult = (e as DioError).response?.statusMessage ?? "ddd";
      } else {
        nextPageLoadResult = 'err in calling api';
      }
    });
    //if api success
    if (nextPageLoadResult == '1') {
      //add vds to list var
      musicVideos.addAll(responseData.items);
      //check if next page
      this.nextPageToken = responseData.nextPageToken;
    }

    notifyListeners();
  }
}
