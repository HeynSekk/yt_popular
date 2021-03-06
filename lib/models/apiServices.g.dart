// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiServices.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiServices implements ApiServices {
  _ApiServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://youtube.googleapis.com/youtube/v3/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PopularVideos> fetchPopularVideos(
      part, chart, videoCategoryId, maxResults, key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'part': part,
      r'chart': chart,
      r'videoCategoryId': videoCategoryId,
      r'maxResults': maxResults,
      r'key': key
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PopularVideos>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'videos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PopularVideos.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PopularVideos> fetchNextPagePopularVideos(
      pageToken, part, chart, videoCategoryId, maxResults, key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageToken': pageToken,
      r'part': part,
      r'chart': chart,
      r'videoCategoryId': videoCategoryId,
      r'maxResults': maxResults,
      r'key': key
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PopularVideos>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'videos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PopularVideos.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchResult> searchByKeyword(part, maxResults, q, key, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'part': part,
      r'maxResults': maxResults,
      r'q': q,
      r'key': key,
      r'type': type
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchResult> searchMoreByKeyword(
      pageToken, part, maxResults, q, key, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageToken': pageToken,
      r'part': part,
      r'maxResults': maxResults,
      r'q': q,
      r'key': key,
      r'type': type
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FetchMultiVdsResult> fetchMultipleVideos(part, id, key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'part': part,
      r'id': id,
      r'key': key
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FetchMultiVdsResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'videos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FetchMultiVdsResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
