import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_movies.g.dart';

@JsonSerializable(explicitToJson: true,)
class NowPlayingMovies {
  final DateRange? dates;
  final int? page;
  final List<NowPlayingMovie>? results;
  final int? totalPages;
  final int? totalResults;

  NowPlayingMovies({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  NowPlayingMovies copyWith({
    DateRange? dates,
    int? page,
    List<NowPlayingMovie>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return NowPlayingMovies(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory NowPlayingMovies.fromJson(Map<String, dynamic> json) => _$NowPlayingMoviesFromJson(json,);

  Map<String, dynamic> toJson() => _$NowPlayingMoviesToJson(this,);
}

@JsonSerializable()
class DateRange {
  final String? maximum;
  final String? minimum;

  DateRange({
    this.maximum,
    this.minimum,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) => _$DateRangeFromJson(json,);

  Map<String, dynamic> toJson() => _$DateRangeToJson(this,);
}

@JsonSerializable()
class NowPlayingMovie {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  NowPlayingMovie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory NowPlayingMovie.fromJson(Map<String, dynamic> json,) => _$NowPlayingMovieFromJson(json,);

  Map<String, dynamic> toJson() => _$NowPlayingMovieToJson(this,);
}