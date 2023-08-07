import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/constants/messages_constants.dart';
import 'package:untitled05/core/layers/presentation/shared-view-components/custom_loader_widget.dart';
import 'package:untitled05/core/layers/presentation/shared-view-components/error_visualisation_widget.dart';

class GenericStateWrapperOnViewModel<T extends BaseViewModel> extends ViewModelWidget<T> {
  final Widget payloadWidget;
  final Object? specialBusyObject;
  final Widget? specialLoader;
  final Widget? specialErrorVisualizer;
  /////////////////////////
  @override
  bool get reactive => true;
  /////////////////////////
  const GenericStateWrapperOnViewModel({
    required this.payloadWidget, this.specialBusyObject, this.specialLoader, this.specialErrorVisualizer,
  }) : super(key: null,);
  /////////////////////////
  @override
  Widget build(BuildContext context, T viewModel,) {
    return Container(
      child: isBusy(viewModel,)
      ? _loadingWidget()
      : (viewModel.hasError) ? _errorWidget(viewModel.error(viewModel,),) : payloadWidget,
    );
  }
  /////////////////////////
  bool isBusy(T viewModel,) => (specialBusyObject != null) ? viewModel.busy(specialBusyObject,) : viewModel.isBusy ;
  /////////////////////////
  Widget _loadingWidget() {
    Widget placeHolderWidget = const Center(
      child: CustomLoader(
        customLoaderTypes: CustomLoaderTypes.ring,
      ),
    );
    if(specialLoader != null){
      placeHolderWidget = specialLoader!;
    }
    return placeHolderWidget;
  }
  /////////////////////////
  Widget _errorWidget(dynamic err,) {
    if (specialErrorVisualizer != null) {
      return specialErrorVisualizer!;
    } else {
      return GeneralErrorVisualisation(
        message: err.toString(),
      );
    }
  }
}
