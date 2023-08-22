import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/presentation/pages/movies-page/movies_page_view_model.dart';
import 'package:untitled05/core/presentation/pages/movies-page/sub-views/most_popular_movies_section.dart';
import 'package:untitled05/core/presentation/pages/movies-page/sub-views/now_playing_movies_section.dart';
import 'package:untitled05/core/presentation/pages/movies-page/sub-views/top_rated_movies_section.dart';
import 'package:untitled05/core/presentation/shared-view-components/custom_loader_widget.dart';
import 'package:untitled05/core/presentation/shared-view-components/generic_state_wrapper_on_view_model_widget.dart';

class MoviesPageView extends StatelessWidget {
  static const String routeName = "/movies-page";
  static const ValueKey<String> routeKey = ValueKey<String>("movies-page",);
  const MoviesPageView() : super(key: null,);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoviesPageViewModel>.reactive(
      key: key,
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      createNewViewModelOnInsert: false,
      disposeViewModel: true,
      viewModelBuilder: () => MoviesPageViewModel.create(),
      onViewModelReady: (viewModel,) => viewModel.onModelReady(),
      onDispose: (viewModel,) => viewModel.onDispose(),
      builder: (_, viewModel, __,) => const _MoviesPageView(key: routeKey,),
    );
  }
}

class _MoviesPageView extends ViewModelWidget<MoviesPageViewModel> {
  @override
  bool get reactive => true;
  /////////////////////////
  const _MoviesPageView({Key? key,}) : super(key: key,);
  /////////////////////////
  @override
  Widget build(BuildContext context, MoviesPageViewModel viewModel,) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.onClose();
        return true;
      },
      child: Scaffold(
        appBar: null,
        body: IgnorePointer(
          ignoring: viewModel.isBusy,
          ignoringSemantics: viewModel.isBusy,
          child: RefreshIndicator(
            onRefresh: () {
              return Future(() => viewModel.onModelReady(),);
            },
            child: GenericStateWrapperOnViewModel<MoviesPageViewModel>(
              payloadWidget: SingleChildScrollView(
                key: const Key('movie-scroll-view',),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const NowPlayingMoviesSection(),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Popular",),
                          InkWell(
                            onTap: () {},
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
                    const MostPopularMoviesWidget(),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Top Rated",),
                          InkWell(
                            onTap: () {},
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
                    const TopRatedMoviesSection(),
                    const SizedBox(height: 50.0,),
                  ],
                ),
              ),
              specialLoader: const CustomLoader(customLoaderTypes: CustomLoaderTypes.shimmer,),
            ),
          ),
        ),
      ),
    );
  }
}

