import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final t = useTimer(Duration.zero, null,);

TimerController useTimer(Duration initialData, void Function(int,)? onTick,) {
  final TimerController timerController = TimerController()..initialData = initialData..onTick = onTick;
  return use(TimerHook(timerController: timerController,),);
}

class TimerController {
  Timer? _timer;
  late Duration initialData;
  void Function(int,)? onTick;

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(
      initialData,
      (Timer timer,) => onTick?.call(timer.tick,),
    );
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}

class TimerHook extends Hook<TimerController> {
  final TimerController timerController;

  const TimerHook({required this.timerController,});

  @override TimerHookState createState() => TimerHookState();
}

class TimerHookState extends HookState<TimerController, TimerHook> {
  @override void initHook() => super.initHook();

  @override TimerController build(BuildContext context,) => hook.timerController;
  
  @override void dispose() => hook.timerController.stopTimer();
}
