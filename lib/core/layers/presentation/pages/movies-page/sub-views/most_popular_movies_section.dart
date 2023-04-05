import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/app/app_route_names.dart';
import 'package:untitled05/app/app_router.dart';
import 'package:untitled05/core/extras/constants/app_constants.dart';
import 'package:untitled05/core/layers/presentation/pages/movies-page/movies_page_view_model.dart';

class MostPopularMoviesWidget extends ViewModelWidget<MoviesPageViewModel> {
  @override
  bool get reactive => true;

  const MostPopularMoviesWidget({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context, MoviesPageViewModel viewModel,) {
    return FadeIn(
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
                AppRouter.instance.navKey.currentState?.pushNamed(AppRouteNames.movieDetailsRoute, arguments:  movie.id,),
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
    );
  }
}
