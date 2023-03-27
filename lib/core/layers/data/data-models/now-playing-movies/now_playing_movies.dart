import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_movies.g.dart';

@JsonSerializable(explicitToJson: true,)
class NowPlayingMovies {
  DateRange? dates;
  int? page;
  List<NowPlayingMovie>? results;
  int? totalPages;
  int? totalResults;

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
  String? maximum;
  String? minimum;

  DateRange({
    this.maximum,
    this.minimum,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) => _$DateRangeFromJson(json,);

  Map<String, dynamic> toJson() => _$DateRangeToJson(this,);
}

@JsonSerializable()
class NowPlayingMovie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

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