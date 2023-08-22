import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:untitled05/extras/services/app_life_cycle_services.dart';

class AppLifeCycleWrapper extends HookWidget {
  final Widget child;
  final List<Tuple3<AppLifecycleState, AppLifecycleState, Function>> appliedStateChangedProcedures;

  const AppLifeCycleWrapper(this.child, this.appliedStateChangedProcedures, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Hooks
    useOnAppLifecycleStateChange(_onAppLifeCycleIsChanged,);

    ///return widget
    return child;
  }

  void _onAppLifeCycleIsChanged(AppLifecycleState? prevState, AppLifecycleState? currentState,) {
    log(prevState.toString(), name: 'AppStateLog-PrevState',);
    log(currentState.toString(), name: 'AppStateLog-CurrentState',);

    ///AppLife cycle stream syncing
    AppLifeCycleService.appLifeCycleListenableStreamController?.add(Tuple2(prevState, currentState,),);

    ///Managing entry point level actions
    for (final element in appliedStateChangedProcedures) {
      if (element.value1 == prevState && element.value2 == currentState) {
        element.value3.call();
      }
    }
  }
}
