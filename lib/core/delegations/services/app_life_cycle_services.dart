import 'dart:async';
import 'dart:ui';
import 'package:dartz/dartz.dart';

class AppLifeCycleService {
  static StreamController<Tuple2<AppLifecycleState?, AppLifecycleState?>> appLifeCycleListenableStreamController = StreamController.broadcast();
}