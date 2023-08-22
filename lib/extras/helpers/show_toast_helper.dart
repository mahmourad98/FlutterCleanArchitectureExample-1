import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled05/config/app_colors.dart';

void showToast(String message, [bool isShort = true,]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.white1,
    textColor: AppColors.greenColor,
    fontSize: 16.0,
  );
}

void showErrorToast(String message, [bool isShort = true,]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.white1,
    textColor: AppColors.redColor,
    fontSize: 16.0,
  );
}
