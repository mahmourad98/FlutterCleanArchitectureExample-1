import 'package:flutter/material.dart';

class AppKeyboardHiderWrapper extends StatelessWidget {
  final Widget child;

  const AppKeyboardHiderWrapper(this.child, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    ///return widget
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}