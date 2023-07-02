import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AppLifeCycleService {
  static StreamController<Tuple2<AppLifecycleState?, AppLifecycleState?>>? _appLifeCycleListenableStreamController;
  static StreamController<Tuple2<AppLifecycleState?, AppLifecycleState?>>? get appLifeCycleListenableStreamController => _appLifeCycleListenableStreamController;

  static void init(){
    _appLifeCycleListenableStreamController ??= StreamController.broadcast();
  }

  static void close() {
    _appLifeCycleListenableStreamController?.close().then(
      (_) => _appLifeCycleListenableStreamController = null,
    );
  }
}
