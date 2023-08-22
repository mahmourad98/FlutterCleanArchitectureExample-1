import 'package:stacked/stacked.dart';

mixin BaseViewModelHelper on BaseViewModel {
  ///FUNDAMENTAL METHODS
  void onModelReady();
  void onDispose();
  void onClose();
  ///RUN MULTIPLE ASYNC METHODS
  Future<T> runBusyAsyncMethods<T>({required Future<T> Function() futureFunction, Object? busyObject,}) async {
    return await runBusyFuture(Future<T>(futureFunction,), busyObject: busyObject,);
  }
  ///RUN MULTIPLE FUTURE
  Future waitMultipleFutures({required List<Future> futureList, Object? busyObject,}) async {
    return await runBusyFuture(Future.wait(futureList, eagerError: true,), busyObject: busyObject,);
  }
  ///RUN MULTIPLE ASYNC METHODS
  Future waitMultipleAsyncMethods({required List<Future Function()> futureList, Object? busyObject,}) async {
    return await runBusyFuture(
      Future.wait(futureList.map((Future Function() e,) => Future(e,),), eagerError: true,), busyObject: busyObject,
    );
  }
  Future<T> runGenericAsyncMethods<T>({
    required Future<T> Function() futureFunction, void Function()? onStart, void Function()? onDone,
  }) async {
    onStart?.call();
    final T response = await futureFunction();
    onDone?.call();
    return response;
  }
  Future<T> runBusyGenericFuture<T>({
    required Future<T> future,
    void Function()? onStart,
    void Function()? onDone,
  }) async {
    onStart?.call();
    final T response = await future;
    onDone?.call();
    return response;
  }
}