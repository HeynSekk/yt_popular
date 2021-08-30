import 'package:json_annotation/json_annotation.dart';

part 'videoData.g.dart';

//PopularVideos
@JsonSerializable(explicitToJson: true)
class PopularVideos {
  List<YtVideo>? items;
  String? nextPageToken;

  PopularVideos({
    required this.items,
    required this.nextPageToken,
  });
  Map<String, dynamic> toJson() => _$PopularVideosToJson(this);
  factory PopularVideos.fromJson(Map<String, dynamic> json) {
    return _$PopularVideosFromJson(json);
  }
}

//SEARCH RESULT
@JsonSerializable(explicitToJson: true)
class SearchResult {
  List<ItemFromSearchResult>? items;
  String? nextPageToken;

  SearchResult({
    required this.items,
    required this.nextPageToken,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return _$SearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemFromSearchResult {
  VideoId id;

  ItemFromSearchResult({
    required this.id,
  });
  factory ItemFromSearchResult.fromJson(Map<String, dynamic> json) {
    return _$ItemFromSearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemFromSearchResultToJson(this);
}

@JsonSerializable()
class VideoId {
  String videoId;

  VideoId({
    required this.videoId,
  });
  factory VideoId.fromJson(Map<String, dynamic> json) {
    return _$VideoIdFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VideoIdToJson(this);
}

//FETCH MULTI VDS RESULT
@JsonSerializable(explicitToJson: true)
class FetchMultiVdsResult {
  final List<YtVideo>? items;

  FetchMultiVdsResult({
    required this.items,
  });
  Map<String, dynamic> toJson() => _$FetchMultiVdsResultToJson(this);

  factory FetchMultiVdsResult.fromJson(Map<String, dynamic> json) =>
      _$FetchMultiVdsResultFromJson(json);
}

//YT VIDEO
@JsonSerializable(explicitToJson: true)
class YtVideo {
  final String id;
  final VdSnippet? snippet;
  final ContentDetails? contentDetails;
  final Statistics? statistics;

  YtVideo({
    required this.id,
    required this.snippet,
    required this.contentDetails,
    required this.statistics,
  });
  Map<String, dynamic> toJson() => _$YtVideoToJson(this);

  factory YtVideo.fromJson(Map<String, dynamic> json) =>
      _$YtVideoFromJson(json);
}

@JsonSerializable()
class ContentDetails {
  String? duration;
  ContentDetails({
    required this.duration,
  });
  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);
}

@JsonSerializable()
class Statistics {
  String? viewCount;
  String? likeCount;
  String? dislikeCount;
  String? favoriteCount;
  String? commentCount;
  Statistics({
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.favoriteCount,
    required this.commentCount,
  });
  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);
}

//VD SNIPPET
@JsonSerializable(explicitToJson: true)
class VdSnippet {
  String? publishedAt;
  String? title;
  String? description;
  Thumbnail? thumbnails;
  String? channelTitle;

  VdSnippet({
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
  });
  Map<String, dynamic> toJson() => _$VdSnippetToJson(this);

  factory VdSnippet.fromJson(Map<String, dynamic> json) =>
      _$VdSnippetFromJson(json);
}

//THUMBNAIL
@JsonSerializable(explicitToJson: true)
class Thumbnail {
  final ThumbnailData? high;
  final ThumbnailData? medium;

  Thumbnail({
    required this.high,
    required this.medium,
  });
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
}

@JsonSerializable()
class ThumbnailData {
  final String? url;
  final int? width;
  final int? height;

  ThumbnailData({
    required this.url,
    required this.width,
    required this.height,
  });
  Map<String, dynamic> toJson() => _$ThumbnailDataToJson(this);

  factory ThumbnailData.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailDataFromJson(json);
}
