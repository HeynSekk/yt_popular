import 'videoData.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'apiServices.g.dart';

@RestApi(baseUrl: "https://youtube.googleapis.com/youtube/v3/")
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  //load popular videos
  @GET("videos")
  Future<PopularVideos> fetchPopularVideos(
    @Query("part") String part, //"snippet",
    @Query("chart") String chart, //"mostPopular",
    @Query("videoCategoryId") int videoCategoryId, //10,
    @Query("maxResults") int maxResults, //30,
    @Query("key") String key,
  );

  @GET("videos")
  Future<PopularVideos> fetchNextPagePopularVideos(
    @Query("pageToken") String pageToken,
    @Query("part") String part, //"snippet",
    @Query("chart") String chart, //"mostPopular",
    @Query("videoCategoryId") int videoCategoryId, //10,
    @Query("maxResults") int maxResults, //30,
    @Query("key") String key,
  );

  //SEARCH
  @GET("search")
  Future<SearchResult> searchByKeyword(
    @Query("part") String part, //"snippet",
    @Query("maxResults") int maxResults, //30,
    @Query("q") String q, //"mostPopular",
    @Query("key") String key,
    @Query("type") String type,
  );

  @GET("search")
  Future<SearchResult> searchMoreByKeyword(
    @Query("pageToken") String pageToken,
    @Query("part") String part, //"snippet",
    @Query("maxResults") int maxResults, //30,
    @Query("q") String q, //"mostPopular",
    @Query("key") String key,
    @Query("type") String type,
  );

  //FETCH MULTIPLE VIDEOS
  @GET("videos")
  Future<FetchMultiVdsResult> fetchMultipleVideos(
    @Query("part") String part,
    @Query("id") String id,
    @Query("key") String key,
  );
}
