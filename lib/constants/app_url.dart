import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String liveBaseUrl = "";
  static final String baseUrl = liveBaseUrl;

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
    liveBaseUrl = dotenv.env['LIVE_BASE_URL'] ?? "";
  }
}

abstract class AuthUrl {
  static final String register = "${AppUrl.baseUrl}/signUp";
  static final String emailVerification =
      "${AppUrl.baseUrl}/api/auth/verify-account";
  static final String resendVerificationMail = "${AppUrl.baseUrl}/resend-otp";
  static final String login = "${AppUrl.baseUrl}/Login";
  static final String verifyEmail = "${AppUrl.baseUrl}/api/auth/verify-account";
  static final String completeProfile = "${AppUrl.baseUrl}/update-user";
  static final String sendVerificationMailForPasswordReset =
      "${AppUrl.baseUrl}/api/auth/send-otp";
  static final String changePassword =
      "${AppUrl.baseUrl}/api/auth/reset-password";
  static final String verifyOtp = "${AppUrl.baseUrl}/emailVrifyOtp";
}

abstract class MediaUrl {
  static const mediaService = "/media-service";
  static String baseUrl = AppUrl.liveBaseUrl + mediaService;
  static final uploadProfilePicture = "$baseUrl/media/profile";
}
