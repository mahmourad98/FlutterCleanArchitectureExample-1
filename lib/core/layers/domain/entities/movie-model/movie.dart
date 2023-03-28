import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart' as movies_dto;

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    required String backdropPath,
    required String overview,
    required List<int> genreIds,
    required double voteAvg,
  }) = _Movie;

  factory Movie.from(movies_dto.Movie other,) => Movie(
    id: other.id ?? 0,
    title: other.title ?? "",
    backdropPath: other.backdropPath ?? "",
    overview: other.overview ?? "",
    genreIds: other.genreIds ?? const [],
    voteAvg: other.voteAverage ?? 0.0,
  );
}