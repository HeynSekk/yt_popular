import 'videoData.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'apiServices.g.dart';

@RestApi(baseUrl: "https://youtube.googleapis.com/youtube/v3/")
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @GET("videos")
  Future<ResponseData> fetchPopularVideos(
    @Query("part") String part, //"snippet",
    @Query("chart") String chart, //"mostPopular",
    @Query("videoCategoryId") int videoCategoryId, //10,
    @Query("maxResults") int maxResults, //30,
    @Query("key") String key,
  );

  @GET("videos")
  Future<ResponseData> fetchNextPagePopularVideos(
    @Query("pageToken") String pageToken,
    @Query("part") String part, //"snippet",
    @Query("chart") String chart, //"mostPopular",
    @Query("videoCategoryId") int videoCategoryId, //10,
    @Query("maxResults") int maxResults, //30,
    @Query("key") String key,
  );
}
