abstract class AppUrl {
  static const String testBaseUrl = "http://127.0.0.1:8000/api";
  static const String liveBaseUrl = "https://cute-blue-squid-toga.cyclic.app";
  static const String baseUrl = liveBaseUrl;
}

abstract class AuthUrl {
  static const String register = "${AppUrl.baseUrl}/signUp";
  static const String emailVerification =
      "${AppUrl.baseUrl}/api/auth/verify-account";
  static const String resendVerificationMail = "${AppUrl.baseUrl}/resend-otp";
  static const String login = "${AppUrl.baseUrl}/Login";
  static const String verifyEmail = "${AppUrl.baseUrl}/api/auth/verify-account";
  static const String completeProfile = "${AppUrl.baseUrl}/update-user";
  static const String sendVerificationMailForPasswordReset =
      "${AppUrl.baseUrl}/api/auth/send-otp";
  static const String changePassword =
      "${AppUrl.baseUrl}/api/auth/reset-password";
  static const String verifyOtp = "${AppUrl.baseUrl}/emailVrifyOtp";
}

abstract class MediaUrl {
  static const mediaService = "/media-service";
  static String baseUrl = AppUrl.liveBaseUrl + mediaService;
  static final uploadProfilePicture = "$baseUrl/media/profile";
}
