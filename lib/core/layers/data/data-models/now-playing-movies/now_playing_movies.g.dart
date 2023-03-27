// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowPlayingMovies _$NowPlayingMoviesFromJson(Map<String, dynamic> json) =>
    NowPlayingMovies(
      dates: json['dates'] == null
          ? null
          : DateRange.fromJson(json['dates'] as Map<String, dynamic>),
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => NowPlayingMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'] as int?,
      totalResults: json['totalResults'] as int?,
    );

Map<String, dynamic> _$NowPlayingMoviesToJson(NowPlayingMovies instance) =>
    <String, dynamic>{
      'dates': instance.dates?.toJson(),
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };

DateRange _$DateRangeFromJson(Map<String, dynamic> json) => DateRange(
      maximum: json['maximum'] as String?,
      minimum: json['minimum'] as String?,
    );

Map<String, dynamic> _$DateRangeToJson(DateRange instance) => <String, dynamic>{
      'maximum': instance.maximum,
      'minimum': instance.minimum,
    };

NowPlayingMovie _$NowPlayingMovieFromJson(Map<String, dynamic> json) =>
    NowPlayingMovie(
      adult: json['adult'] as bool?,
      backdropPath: json['backdropPath'] as String?,
      genreIds:
          (json['genreIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['originalLanguage'] as String?,
      originalTitle: json['originalTitle'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['posterPath'] as String?,
      releaseDate: json['releaseDate'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: json['voteCount'] as int?,
    );

Map<String, dynamic> _$NowPlayingMovieToJson(NowPlayingMovie instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdropPath': instance.backdropPath,
      'genreIds': instance.genreIds,
      'id': instance.id,
      'originalLanguage': instance.originalLanguage,
      'originalTitle': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'posterPath': instance.posterPath,
      'releaseDate': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
    };
