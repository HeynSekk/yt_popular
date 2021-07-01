import 'package:json_annotation/json_annotation.dart';

part 'videoData.g.dart';

//RESPONES  DATA
@JsonSerializable(explicitToJson: true)
class ResponseData {
  List<YtVideo> items;
  String nextPageToken;

  ResponseData({
    required this.items,
    required this.nextPageToken,
  });
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
  factory ResponseData.fromJson(Map<String, dynamic> json) {
    print('GONNA SERIALIZE JSON TO RESPONSE DATA OBJECT');
    return _$ResponseDataFromJson(json);
  }
}

//YT VIDEO
@JsonSerializable(explicitToJson: true)
class YtVideo {
  String id;
  VdSnippet snippet;

  YtVideo({
    required this.id,
    required this.snippet,
  });
  Map<String, dynamic> toJson() => _$YtVideoToJson(this);

  factory YtVideo.fromJson(Map<String, dynamic> json) =>
      _$YtVideoFromJson(json);
}

//VD SNIPPET
@JsonSerializable(explicitToJson: true)
class VdSnippet {
  String publishedAt;
  String title;
  String description;
  Thumbnail thumbnails;
  String channelTitle;

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
  final ThumbnailData high;

  Thumbnail({
    required this.high,
  });
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
}

@JsonSerializable()
class ThumbnailData {
  final String url;
  final int width;
  final int height;

  ThumbnailData({
    required this.url,
    required this.width,
    required this.height,
  });
  Map<String, dynamic> toJson() => _$ThumbnailDataToJson(this);

  factory ThumbnailData.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailDataFromJson(json);
}
