import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/constants/app_constants.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';
import 'package:untitled05/core/layers/presentation/pages/movie-details-page/movie_details_page_view_model.dart';

class MovieDetailsPageView extends StatelessWidget {
  final int _movieId;

  const MovieDetailsPageView(this._movieId, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return ViewModelBuilder<MovieDetailsPageViewModel>.reactive(
      key: key,
      fireOnViewModelReadyOnce: true,
      disposeViewModel: true,
      viewModelBuilder: () => MovieDetailsPageViewModel(_movieId,),
      onViewModelReady: (viewModel,) => viewModel.onModelReady(),
      onDispose: (viewModel,) => viewModel.onDispose(),
      builder: (_, viewModel, __,) => WillPopScope(
        onWillPop: () async {
          viewModel.onClose();
          return true;
        },
        child: Scaffold(
          appBar: null,
          body: (viewModel.isBusy)
          ? const SizedBox.expand(child: Center(child: CircularProgressIndicator(),),)
          : (viewModel.hasError)
          ? const SizedBox.expand(child: Center(child: Text("Sorry Some Error Has Occurred",),),)
          : CustomScrollView(
            key: const Key('movie-details-scroll-view'),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadeIn(
                    duration: const Duration(milliseconds: 500,),
                    child: ShaderMask(
                      shaderCallback: (rect,) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5, 1.0, 1.0],
                      ).createShader(
                        Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                      ),
                      blendMode: BlendMode.dstIn,
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        imageUrl: AppConstants.getImageFullPath(viewModel.movieDetails.backdropPath,),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500,),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.movieDetails.title,
                          style: const TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8.0,),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(4.0,),
                              ),
                              child: Text(
                                viewModel.movieDetails.releaseDate.split('-',)[0],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0,),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 4.0,),
                                Text(
                                  (viewModel.movieDetails.voteAvg / 2).toStringAsFixed(1,),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(width: 4.0,),
                                Text(
                                  '(${viewModel.movieDetails.voteAvg})',
                                  style: const TextStyle(
                                    fontSize: 1.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16.0,),
                            Text(
                              _showDuration(viewModel.movieDetails.runtime,),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        Text(
                          viewModel.movieDetails.overview,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8.0,),
                        Text(
                          'Genres: ${_showGenres(viewModel.movieDetails.genreIds,)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0,),
                sliver: SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500,),
                    child: Text(
                      'More like this'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              // Tab(text: 'More like this'.toUpperCase()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0,),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (buildContext, itemIndex,) {
                      final recommendation = recommendationDummy[itemIndex];
                      return FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0,),),
                          child: CachedNetworkImage(
                            imageUrl: AppConstants.getImageFullPath(recommendation.backdropPath,),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 170.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0,),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error,) => const Icon(Icons.error,),
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    childCount: recommendationDummy.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                    crossAxisCount: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _showGenres(List<Genres> genres,) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) return result;
    return result.substring(0, (result.length - 2),);
  }

  String _showDuration(int runtime,) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

List<Recommendation> recommendationDummy = [
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
  const Recommendation(
    backdropPath: "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
    id: 924482,
  ),
];

class Recommendation {
  final String backdropPath; final int id;

  const Recommendation({required this.id, required this.backdropPath,});
}