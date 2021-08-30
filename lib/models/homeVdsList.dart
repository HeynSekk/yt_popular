import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:yt_popular/models/apiServices.dart';
import 'package:yt_popular/models/responseTransformer.dart';
import 'package:yt_popular/models/videoData.dart';
import 'videoData.dart';
import 'package:dio/dio.dart';
import 'sensitiveData.dart';

class HomeVdsList extends ChangeNotifier {
  List<YtVideo> vds = [];
  String loadResult = '1';
  String nextPageLoadResult = '1'; //1=initial or loaded, l= loading, other=err
  String? nextPageToken;
  int currentVdCategoryId = 28;
  //load vds
  Future<void> loadVideos(int videoCategoryId) async {
    //change app state (loading and current vd categ id)
    currentVdCategoryId = videoCategoryId;
    loadResult = 'l';
    notifyListeners();
    //call api
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger()); //for logging
    final ApiServices client = new ApiServices(dio);
    PopularVideos responseData = await client
        .fetchPopularVideos(
      "snippet,contentDetails,statistics",
      "mostPopular",
      videoCategoryId,
      10,
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
      return PopularVideos(items: [], nextPageToken: null);
    });
    //if api success
    if (loadResult == '1') {
      //transform count to shorter form
      //add vds to list var
      vds =
          ResponseTransformer().transformResponseVds(responseData.items ?? []);
      //check if next page
      nextPageToken = responseData.nextPageToken;
    }

    notifyListeners();
  }

  //load more vds
  Future<void> loadMoreVideos(int videoCategoryId) async {
    //change app state to loading
    this.nextPageLoadResult = 'l';
    notifyListeners();
    //call api with next page token
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger());
    final ApiServices client = new ApiServices(dio);
    PopularVideos responseData = await client
        .fetchNextPagePopularVideos(
      this.nextPageToken!,
      "snippet,contentDetails,statistics",
      "mostPopular",
      videoCategoryId,
      10,
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
      return PopularVideos(items: [], nextPageToken: null);
    });
    //if api success
    if (nextPageLoadResult == '1') {
      //add vds to list var
      vds.addAll(
          ResponseTransformer().transformResponseVds(responseData.items ?? []));
      //check if next page
      this.nextPageToken = responseData.nextPageToken;
    }

    notifyListeners();
  }
}
