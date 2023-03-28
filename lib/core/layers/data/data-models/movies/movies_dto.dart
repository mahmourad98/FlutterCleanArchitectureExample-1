import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_dto.g.dart';

@JsonSerializable(explicitToJson: true,)
class MoviesDto {
  DateRange? dates;
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  MoviesDto({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MoviesDto copyWith({
    DateRange? dates,
    int? page,
    List<Movie>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MoviesDto(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory MoviesDto.fromJson(Map<String, dynamic> json) => _$MoviesDtoFromJson(json,);

  Map<String, dynamic> toJson() => _$MoviesDtoToJson(this,);
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
class Movie {
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

  Movie({
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

  factory Movie.fromJson(Map<String, dynamic> json,) => _$MovieFromJson(json,);

  Map<String, dynamic> toJson() => _$MovieToJson(this,);
}