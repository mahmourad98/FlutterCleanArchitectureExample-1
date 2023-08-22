import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled05/core/data/data-models/movie-details/movie_details_dto.dart' as movie_details_dto;

part 'movie_details.freezed.dart';

@Freezed(copyWith: true, equal: true, toStringOverride: true,)
class MovieDetails with _$MovieDetails {
  const factory MovieDetails({
    required int id,
    required String title,
    required String backdropPath,
    required String overview,
    required List<Genres> genreIds,
    required double voteAvg,
    required String releaseDate,
    required int runtime,
  }) = _MovieDetails;

  factory MovieDetails.from(movie_details_dto.MovieDetailsDto other,) => MovieDetails(
    id: other.id ?? 0,
    title: other.title ?? "",
    backdropPath: other.backdrop_path ?? "",
    overview: other.overview ?? "",
    genreIds: other.genres?.map((e,) => Genres.from(e,),).toList() ?? const <Genres>[],
    voteAvg: other.vote_average ?? 0.0,
    releaseDate: other.release_date ?? "",
    runtime: other.runtime ?? 0,
  );
}

@Freezed(copyWith: true, equal: true, toStringOverride: true,)
class Genres with _$Genres {
  const factory Genres({
    required int id,
    required String name,
  }) = _Genres;

  factory Genres.from(movie_details_dto.Genres other,) => Genres(
    id: other.id ?? 0,
    name: other.name ?? "",
  );
}