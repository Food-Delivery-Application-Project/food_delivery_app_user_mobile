import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/auth/login_model.dart';
import 'package:food_delivery_app/models/auth/otp_model.dart';
import 'package:food_delivery_app/models/auth/signup_model.dart';
import 'package:food_delivery_app/models/user/register_user_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:http/http.dart';

abstract class AuthController {
  static Future<ApiResponse<SignUpModel>> register(
      String email, String password) async {
    final url = AuthUrl.register;
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

  static Future<ApiResponse<OtpModel>> sendOtp(String email) async {
    final url = AuthUrl.resendVerificationMail;

    try {
      final response = await ApiManager.postRequest(
        {"email": email},
        url,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);

        ApiResponse<OtpModel> model = ApiResponse.fromJson(
          body,
          (data) => OtpModel.fromJson(body['data']),
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
    final url = AuthUrl.verifyOtp;

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
    final url = AuthUrl.login;

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

  static Future<ApiResponse<dynamic>> completeProfile({
    required RegisterUserModel user,
  }) async {
    final url = "${AuthUrl.completeProfile}/${user.userId}";
    try {
// multi part request
      var request = MultipartRequest(
        'PUT',
        Uri.parse(url),
      );
      request.headers.addAll({"authorization": "Bearer ${user.pushToken}"});

      // send the file as a part of the request

      // if the user.profilePic parameter is not null then send the file otherwise
      // don't send the file
      if (user.profilePic != null) {
        request.files.add(
          MultipartFile(
            'ProfileImage',
            user.profilePic!.readAsBytes().asStream(),
            user.profilePic!.lengthSync(),
            filename: user.profilePic!.path.split('/').last,
          ),
        );
      } else {}

      // send other fields
      request.fields["Phone"] = user.phone.toString();
      request.fields["fullName"] = user.name.toString();

      // send request
      var response = await request.send();
      // print response
      var body = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        // success
        ApiResponse<dynamic> model = ApiResponse<dynamic>.fromJson(
          body,
          (data) => null,
        );
        return model;
      } else {
        throw Exception(body['message']);
      }
    } catch (_) {
      rethrow;
    }
  }
}
