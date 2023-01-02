import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled05/core/layers/data/data-models/now-playing-movies/now_playing_movies.dart';

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

  factory Movie.from(NowPlayingMovie other,) => Movie(
    id: other.id ?? 0,
    title: other.title ?? "",
    backdropPath: other.backdropPath ?? "",
    overview: other.overview ?? "",
    genreIds: other.genreIds ?? const [],
    voteAvg: other.voteAverage ?? 0.0,
  );
}