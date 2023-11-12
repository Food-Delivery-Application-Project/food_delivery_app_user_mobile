import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AppToast {
  static success(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.success, gravity);
  }

  static danger(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.dangerColor, gravity);
  }

  static normal(message, [ToastGravity? gravity]) {
    _appToast(message, AppColors.primary, gravity);
  }
}

void _appToast(String message, color, [ToastGravity? gravity]) {
  toast(message.replaceAll("Exception:", ""),
      bgColor: color, length: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
}
