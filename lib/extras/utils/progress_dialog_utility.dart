import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class ProgressDialogUtility {
  static BuildContext get _buildContext => serviceLocator<AppNavigationService>().navKey.currentContext!;
  //////////////////////////
  static ProgressDialog create({Widget? bodyWidget, String? message, BuildContext? buildContext,}) {
    final progressDialog =  ProgressDialog(
      buildContext ?? _buildContext,
      customBody: null,
      type: ProgressDialogType.normal,
      textDirection: isRTL() ? TextDirection.rtl : TextDirection.ltr,
      isDismissible: false,
      showLogs: false,
    );
    _setStyle(progressDialog: progressDialog, bodyWidget: bodyWidget, message: message,);
    return progressDialog;
  }
  //////////////////////////
  static void _setStyle({required ProgressDialog progressDialog, Widget? bodyWidget, String? message,}) {
    return progressDialog.style(
      progressWidget: bodyWidget,
      message: message,
      borderRadius: 12.0,
      elevation: 10.0,
      textAlign: TextAlign.left,
      progressWidgetAlignment: Alignment.centerLeft,
      backgroundColor: Colors.white,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      messageTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.all(16.0,),
      widgetAboveTheDialog: null,
    );
  }
  //////////////////////////
  static void updateMessage({required ProgressDialog progressDialog, required String message,}) {
    return progressDialog.update(
      message: message,
    );
  }
}