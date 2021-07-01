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
  );
}

Map<String, dynamic> _$YtVideoToJson(YtVideo instance) => <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet.toJson(),
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
