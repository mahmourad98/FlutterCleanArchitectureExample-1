// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsDto _$MovieDetailsDtoFromJson(Map<String, dynamic> json) =>
    MovieDetailsDto(
      adult: json['adult'] as bool?,
      backdrop_path: json['backdrop_path'] as String?,
      belongs_to_collection: json['belongs_to_collection'],
      budget: json['budget'] as int?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      imdb_id: json['imdb_id'] as String?,
      original_language: json['original_language'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      poster_path: json['poster_path'],
      production_companies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompanies.fromJson(e as Map<String, dynamic>))
          .toList(),
      production_countries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountries.fromJson(e as Map<String, dynamic>))
          .toList(),
      release_date: json['release_date'] as String?,
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      spoken_languages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguages.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: json['vote_count'] as int?,
    );

Map<String, dynamic> _$MovieDetailsDtoToJson(MovieDetailsDto instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'belongs_to_collection': instance.belongs_to_collection,
      'budget': instance.budget,
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdb_id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'production_companies':
          instance.production_companies?.map((e) => e.toJson()).toList(),
      'production_countries':
          instance.production_countries?.map((e) => e.toJson()).toList(),
      'release_date': instance.release_date,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages':
          instance.spoken_languages?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };

Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompanies _$ProductionCompaniesFromJson(Map<String, dynamic> json) =>
    ProductionCompanies(
      id: json['id'] as int?,
      logo_path: json['logo_path'] as String?,
      name: json['name'] as String?,
      origin_country: json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompaniesToJson(
        ProductionCompanies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logo_path,
      'name': instance.name,
      'origin_country': instance.origin_country,
    };

ProductionCountries _$ProductionCountriesFromJson(Map<String, dynamic> json) =>
    ProductionCountries(
      iso_3166_1: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCountriesToJson(
        ProductionCountries instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso_3166_1,
      'name': instance.name,
    };

SpokenLanguages _$SpokenLanguagesFromJson(Map<String, dynamic> json) =>
    SpokenLanguages(
      iso_639_1: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguagesToJson(SpokenLanguages instance) =>
    <String, dynamic>{
      'iso_639_1': instance.iso_639_1,
      'name': instance.name,
    };
