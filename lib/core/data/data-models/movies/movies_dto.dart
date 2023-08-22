// ignore_for_file: non_constant_identifier_names
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_dto.g.dart';

@JsonSerializable(explicitToJson: true,)
class MoviesDto {
  DateRange? dates;
  int? page;
  List<Movie>? results;
  int? total_pages;
  int? total_results;

  MoviesDto({
    this.dates,
    this.page,
    this.results,
    this.total_pages,
    this.total_results,
  });

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
  String? backdrop_path;
  List<int>? genre_ids;
  int? id;
  String? original_language;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  String? release_date;
  String? title;
  bool? video;
  double? vote_average;
  int? vote_count;

  Movie({
    this.adult,
    this.backdrop_path,
    this.genre_ids,
    this.id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  factory Movie.fromJson(Map<String, dynamic> json,) => _$MovieFromJson(json,);

  Map<String, dynamic> toJson() => _$MovieToJson(this,);
}