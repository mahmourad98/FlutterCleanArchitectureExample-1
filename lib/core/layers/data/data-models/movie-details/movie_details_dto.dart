// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_dto.g.dart';

@JsonSerializable(explicitToJson: true,)
class MovieDetailsDto {
  bool? adult;
  String? backdrop_path;
  dynamic belongs_to_collection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdb_id;
  String? original_language;
  String? original_title;
  String? overview;
  double? popularity;
  dynamic poster_path;
  List<ProductionCompanies>? production_companies;
  List<ProductionCountries>? production_countries;
  String? release_date;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spoken_languages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? vote_average;
  int? vote_count;

  MovieDetailsDto({
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdb_id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.revenue,
    this.runtime,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) => _$MovieDetailsDtoFromJson(json,);

  Map<String, dynamic> toJson() => _$MovieDetailsDtoToJson(this,);
}

@JsonSerializable()
class Genres {
  int? id;
  String? name;

  Genres({
    this.id,
    this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json,);

  Map<String, dynamic> toJson() => _$GenresToJson(this,);
}

@JsonSerializable()
class ProductionCompanies {
  int? id;
  String? logo_path;
  String? name;
  String? origin_country;

  ProductionCompanies({
    this.id,
    this.logo_path,
    this.name,
    this.origin_country,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json,);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this,);
}

@JsonSerializable()
class ProductionCountries {
  String? iso_3166_1;
  String? name;

  ProductionCountries({
    this.iso_3166_1,
    this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json,);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this,);
}

@JsonSerializable()
class SpokenLanguages {
  String? iso_639_1;
  String? name;

  SpokenLanguages({
    this.iso_639_1,
    this.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json,);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this,);
}