import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

mixin BaseViewModelHelper on BaseViewModel {
  void onModelReady();
  void onDispose();
  void onClose();

  static Future<T> runGenericBusyFutureAsFuture<T>(Future<T> Function() asyncFunction,) async {
    BotToast.showCustomLoading(
      toastBuilder: (cancelFunc,) => const CircularProgressIndicator(),
      crossPage: true,
      clickClose: true,
      align: Alignment.center,
    );
    final T _response = await asyncFunction();
    BotToast.closeAllLoading();
    return _response;
  }

  ///RUN MULTIPLE ASYNC METHODS
  Future<T> runAsyncMethods<T>(Future<T> Function() futureFunction, {Object? busyObject,}) async {
    return await runBusyFuture(Future<T>(futureFunction,), busyObject: busyObject,);
  }

  ///RUN MULTIPLE FUTURE
  Future waitMultipleFutures(List<Future> futureList, {Object? busyObject,}) async {
    return await runBusyFuture(Future.wait(futureList, eagerError: true,), busyObject: busyObject,);
  }

  Future<T> runGenericAsyncMethods<T>(
    Future<T> Function() futureFunction, void Function()? onStart, void Function()? onDone,
  ) async {
    (onStart != null) ? onStart.call() : BotToast.showCustomLoading(
      toastBuilder: (cancelFunc,) => const SizedBox.expand(child: Center(child: CircularProgressIndicator(),),),
      crossPage: true,
      clickClose: true,
      align: Alignment.center,
    );
    final T response = await futureFunction();
    (onDone != null) ? onDone.call() : BotToast.closeAllLoading();
    return response;
  }

  Future<T> runGenericFuture<T>(Future<T> future, void Function()? onStart, void Function()? onDone,) async {
    (onStart != null) ? onStart.call() : BotToast.showCustomLoading(
      toastBuilder: (cancelFunc,) => const SizedBox.expand(child: Center(child: CircularProgressIndicator(),),),
      crossPage: true,
      clickClose: true,
      align: Alignment.center,
    );
    final T response = await future;
    (onDone != null) ? onDone.call() : BotToast.closeAllLoading();
    return response;
  }
}