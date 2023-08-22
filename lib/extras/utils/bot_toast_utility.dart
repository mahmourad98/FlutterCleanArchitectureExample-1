import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:untitled05/extras/helpers/general_usage_helper.dart';

class BotToastUtility {
  static void showCustomLoader({
    void Function()? onClose,
    Widget? bodyWidget ,
  }) {
    BotToast.showCustomLoading(
      toastBuilder: (_,) => bodyWidget.isNotNull ? bodyWidget : _defaultLoader,
      onClose: onClose,
      backgroundColor: Colors.transparent,
      crossPage: true,
      useSafeArea: true,
      clickClose: false,
      allowClick: false,
      ignoreContentClick: true,
      enableKeyboardSafeArea: false,
      align: Alignment.center,
      backButtonBehavior: BackButtonBehavior.none,
    );
    return;
  }

  static void closeAll() { return BotToast.closeAllLoading(); }
  
  static get _defaultLoader {
    return const Center(
      child: SizedBox(
        height: 48.0,
        width: 48.0,
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent,),
        ),
      )
    );
  }
}