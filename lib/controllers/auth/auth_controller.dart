import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/auth/auth_model.dart';
import 'package:food_delivery_app/models/auth/login_model.dart';
import 'package:food_delivery_app/models/auth/signup_model.dart';
import 'package:food_delivery_app/models/user/register_user_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

abstract class AuthController {
  static Future<AuthModel> _getResponse(var response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      return AuthModel.fromJson(body);
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }
  }

  static Future<ApiResponse<SignUpModel>> register(
      String email, String password) async {
    const url = AuthUrl.register;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);

        ApiResponse<SignUpModel> model = ApiResponse<SignUpModel>.fromJson(
          body,
          (data) => SignUpModel.fromJson(body['data']),
        );
        return model;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse<dynamic>> sendOtp(String email) async {
    const url = AuthUrl.resendVerificationMail;

    try {
      final response = await ApiManager.postRequest(
        {"email": email},
        url,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);

        ApiResponse<dynamic> model = ApiResponse.fromJson(
          body,
          (data) => null,
        );
        return model;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse<dynamic>> verifyOtp(
      String email, String otp) async {
    const url = AuthUrl.verifyOtp;

    try {
      final response = await ApiManager.postRequest(
        {"email": email, "code": otp},
        url,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);

        ApiResponse<dynamic> model = ApiResponse.fromJson(
          body,
          (data) => null,
        );
        return model;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse<LoginModel>> login(
      String email, String password) async {
    const url = AuthUrl.login;

    try {
      final response = await ApiManager.postRequest(
        {"email": email, "password": password},
        url,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);
        ApiResponse<LoginModel> model = ApiResponse.fromJson(
          body,
          (data) => LoginModel.fromJson(body['data']),
        );
        return model;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> verifyAccount(String email) async {
    final url = "${AuthUrl.verifyEmail}/$email";

    try {
      final response = await ApiManager.bodyLessPut(url);
      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> completeProfile({
    required RegisterUserModel user,
    required String token,
  }) async {
    const url = AuthUrl.completeProfile;
    try {
      final response = await ApiManager.putRequest(
        user.toJson(),
        url,
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      );
      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> sendVerificaionMailForPasswordChange(
    String email,
  ) async {
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();
    final url = "${AuthUrl.sendVerificationMailForPasswordReset}/$email";
    final response =
        await ApiManager.bodyLessPost(url, headers: <String, String>{
      "Authorization": token!,
      "Intent": "Reset-Password",
      "Content-Type": "application/json"
    });
    return _getResponse(response);
  }

  static Future<AuthModel> changePassword(
    String userId,
    String password,
  ) async {
    const url = AuthUrl.changePassword;
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();

    try {
      final response = await ApiManager.putRequest(
          {"userId": userId, "password": password}, url,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": token.toString(),
          });

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
