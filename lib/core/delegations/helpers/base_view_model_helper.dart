import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import 'package:untitled05/core/layers/presentation/shared_views/custom_circular_loader.dart';

mixin BaseViewModelHelper on BaseViewModel {
  void onModelReady();
  void onClose();

  static Future<T> runGenericBusyFutureAsFuture<T>(Future<T> Function() asyncFunction,) async {
    BotToast.showCustomLoading(
      toastBuilder: (cancelFunc,) => const CustomLoader(),
      crossPage: true,
      clickClose: true,
      align: Alignment.center,
    );
    final T _response = await asyncFunction();
    BotToast.closeAllLoading();
    return _response;
  }

  ///Run multiple futures
  Future runFutureMethods(Future<void> Function() asyncFunction, {Object? busyObject,}) async {
    await runBusyFuture(asyncFunction(), busyObject: busyObject,);
    return;
  }

  ///Run multiple futures

  Future waitMultipleFutures(List<Future> futureList, [Object? busyObject,]) async {
    await runBusyFuture(Future.wait(futureList, eagerError: true,), busyObject: busyObject,);
    return;
  }
}