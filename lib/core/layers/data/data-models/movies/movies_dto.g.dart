// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesDto _$MoviesDtoFromJson(Map<String, dynamic> json) => MoviesDto(
      dates: json['dates'] == null
          ? null
          : DateRange.fromJson(json['dates'] as Map<String, dynamic>),
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_pages: json['total_pages'] as int?,
      total_results: json['total_results'] as int?,
    );

Map<String, dynamic> _$MoviesDtoToJson(MoviesDto instance) => <String, dynamic>{
      'dates': instance.dates?.toJson(),
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };

DateRange _$DateRangeFromJson(Map<String, dynamic> json) => DateRange(
      maximum: json['maximum'] as String?,
      minimum: json['minimum'] as String?,
    );

Map<String, dynamic> _$DateRangeToJson(DateRange instance) => <String, dynamic>{
      'maximum': instance.maximum,
      'minimum': instance.minimum,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      adult: json['adult'] as bool?,
      backdrop_path: json['backdrop_path'] as String?,
      genre_ids:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      original_language: json['original_language'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      poster_path: json['poster_path'] as String?,
      release_date: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: json['vote_count'] as int?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'genre_ids': instance.genre_ids,
      'id': instance.id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'release_date': instance.release_date,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
