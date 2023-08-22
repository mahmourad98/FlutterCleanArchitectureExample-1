import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled05/core/data/data-models/movies/movies_dto.dart' as movies_dto;

part 'movie.freezed.dart';

@Freezed(copyWith: true, equal: true, toStringOverride: true,)
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    required String backdropPath,
    required String overview,
    required List<int> genreIds,
    required double voteAvg,
    required String releaseDate,
  }) = _Movie;

  factory Movie.from(movies_dto.Movie other,) => Movie(
    id: other.id ?? 0,
    title: other.title ?? "",
    backdropPath: other.backdrop_path ?? "",
    overview: other.overview ?? "",
    genreIds: other.genre_ids ?? const [],
    voteAvg: other.vote_average ?? 0.0,
    releaseDate: other.release_date ?? "",
  );
}