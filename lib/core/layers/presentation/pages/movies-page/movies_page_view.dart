import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/constants/app_constants.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/presentation/pages/movies-page/movies_page_view_model.dart';

class MoviesPageView extends StatelessWidget {
  const MoviesPageView({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return ViewModelBuilder<MoviesPageViewModel>.reactive(
      key: key,
      fireOnViewModelReadyOnce: true,
      disposeViewModel: true,
      viewModelBuilder: () => MoviesPageViewModel(),
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
          ? SizedBox.expand(
            child: Center(
              child: SizedBox.fromSize(
                size: const Size(64.0, 64.0),
                child: const Flexible(child: CircularProgressIndicator(strokeWidth: 12.0,),),
              ),
            ),
          )
          : SingleChildScrollView(
            key: const Key('movie-scroll-view',),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  duration: const Duration(milliseconds: 500,),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400.0,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason,) => {},
                    ),
                    items: viewModel.nowPlayingMovies.map(
                      (item) => GestureDetector(
                        key: const Key('open-movie-minimal-detail',),
                        onTap: () {
                          /// TODO : NAVIGATE TO MOVIE DETAILS
                        },
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect,) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1,],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height,),
                              ),
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                height: 560.0,
                                imageUrl: AppConstants.getImageFullPath(item.backdropPath,),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error,) => const Center(child: Icon(Icons.error,)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.redAccent,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 4.0,),
                                        Text(
                                          'Now Playing'.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0,),
                                    child: Text(
                                      item.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Popular",
                      ),
                      InkWell(
                        onTap: () => {
                          ///TODO : NAVIGATION TO POPULAR SCREEN
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0,),
                          child: Row(
                            children: const [
                              Text('See More', style: TextStyle(color: Colors.black),),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeIn(
                  duration: const Duration(milliseconds: 500,),
                  child: SizedBox(
                    height: 170.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                      itemCount: viewModel.mostPopularMovies.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.mostPopularMovies[index];
                        return Container(
                          padding: const EdgeInsets.only(right: 8.0,),
                          child: InkWell(
                            onTap: () => {
                              /// TODO : NAVIGATE TO  MOVIE DETAILS
                            },
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8.0,),),
                              child: CachedNetworkImage(
                                width: 120.0,
                                fit: BoxFit.cover,
                                imageUrl: AppConstants.getImageFullPath(movie.backdropPath,),
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Rated",
                      ),
                      InkWell(
                        onTap: () => {
                          /// TODO : NAVIGATION TO Top Rated Movies Screen
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0,),
                          child: Row(
                            children: const [
                              Text('See More', style: TextStyle(color: Colors.black,),),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeIn(
                  duration: const Duration(milliseconds: 500,),
                  child: SizedBox(
                    height: 170.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                      itemCount: viewModel.topRatedMovies.length,
                      itemBuilder: (context, index,) {
                        final movie = viewModel.topRatedMovies[index];
                        return Container(
                          padding: const EdgeInsets.only(right: 8.0,),
                          child: InkWell(
                            onTap: () => {
                              ///TODO : NAVIGATE TO  MOVIE DETAILS
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0,),),
                              child: CachedNetworkImage(
                                width: 120.0,
                                fit: BoxFit.cover,
                                imageUrl: AppConstants.getImageFullPath(movie.backdropPath,),
                                placeholder: (context, url,) => Shimmer.fromColors(
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Movie> moviesList = [
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview: "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview:
    "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview:
    "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview:
    "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview:
    "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
  const Movie(
    backdropPath: "/nmGWzTLMXy9x7mKd8NKPLmHtWGa.jpg",
    genreIds: [
      14,
      28,
      12,
    ],
    id: 453395,
    overview:
    "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.",
    releaseDate: "2022-05-04",
    title: "Movie Title",
    voteAvg: 5.0,
  ),
];

