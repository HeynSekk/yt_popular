// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData(
    items: (json['items'] as List<dynamic>)
        .map((e) => YtVideo.fromJson(e as Map<String, dynamic>))
        .toList(),
    nextPageToken: json['nextPageToken'] as String,
  );
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextPageToken': instance.nextPageToken,
    };

YtVideo _$YtVideoFromJson(Map<String, dynamic> json) {
  return YtVideo(
    id: json['id'] as String,
    snippet: VdSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    contentDetails:
        ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
    statistics: Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$YtVideoToJson(YtVideo instance) => <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet.toJson(),
      'contentDetails': instance.contentDetails.toJson(),
      'statistics': instance.statistics.toJson(),
    };

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) {
  return ContentDetails(
    duration: json['duration'] as String,
  );
}

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'duration': instance.duration,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) {
  return Statistics(
    viewCount: json['viewCount'] as String,
    likeCount: json['likeCount'] as String,
    dislikeCount: json['dislikeCount'] as String,
    favouriteCount: json['favouriteCount'] as String,
    commentCount: json['commentCount'] as String,
  );
}

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'favouriteCount': instance.favouriteCount,
      'commentCount': instance.commentCount,
    };

VdSnippet _$VdSnippetFromJson(Map<String, dynamic> json) {
  return VdSnippet(
    publishedAt: json['publishedAt'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    thumbnails: Thumbnail.fromJson(json['thumbnails'] as Map<String, dynamic>),
    channelTitle: json['channelTitle'] as String,
  );
}

Map<String, dynamic> _$VdSnippetToJson(VdSnippet instance) => <String, dynamic>{
      'publishedAt': instance.publishedAt,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails.toJson(),
      'channelTitle': instance.channelTitle,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return Thumbnail(
    high: ThumbnailData.fromJson(json['high'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'high': instance.high.toJson(),
    };

ThumbnailData _$ThumbnailDataFromJson(Map<String, dynamic> json) {
  return ThumbnailData(
    url: json['url'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
  );
}

Map<String, dynamic> _$ThumbnailDataToJson(ThumbnailData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
