import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:untitled05/core/layers/data/enums/environment_type.dart';
import 'package:untitled05/core/layers/presentation/shared_views/app_life_cycle_wrapper.dart';

extension AppEntryPointEnvHelper on Widget? {
  ///Here all the test env wrapping widgets must be implemented !
  Widget renderTreeHandler(EnvironmentType environmentType, List<Tuple3<AppLifecycleState, AppLifecycleState, Function>> appliedStateChangedProcedures,) {
    final extShadow = this ?? const SizedBox.expand();

    ///App Lifecycle manger
    final Widget mainWidget = AppLifeCycleWrapper(extShadow, appliedStateChangedProcedures,);

    ///
    switch (environmentType) {

      ///ProductionMode
      case EnvironmentType.production:
      case EnvironmentType.acceptance:

      ///Development Mode
      case EnvironmentType.testing:
        return mainWidget;

      ///Development Mode
      case EnvironmentType.development:
        return mainWidget;
    }
  }
}
