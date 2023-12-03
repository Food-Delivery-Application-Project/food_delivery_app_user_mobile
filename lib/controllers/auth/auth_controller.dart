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
  static Future<ApiResponse> register(String email, String password) async {
    const url = AuthUrl.register;
    final body = {'email': email, 'password': password};
    final response = await ApiManager.postRequest(body, url);
    final responseBody = jsonDecode(response.body);
    final model = SignUpModel.fromJson(responseBody['data']);
    return ApiManager.returnModel(response, model: model);
  }

  static Future<ApiResponse> sendOtp(String email) async {
    const url = AuthUrl.resendVerificationMail;
    final response = await ApiManager.postRequest({"email": email}, url);
    final body = jsonDecode(response.body);
    final model = OtpModel.fromJson(body['data']);
    return ApiManager.returnModel(response, model: model);
  }

  static Future<ApiResponse> verifyOtp(String email, String otp) async {
    const url = AuthUrl.verifyOtp;
    final body = {"email": email, "code": otp};
    final response = await ApiManager.postRequest(body, url);
    return ApiManager.returnModel(response);
  }

  static Future<ApiResponse> login(String email, String password) async {
    const url = AuthUrl.login;
    final body = {"email": email, "password": password};
    final response = await ApiManager.postRequest(body, url);
    final responseBody = jsonDecode(response.body);
    final model = LoginModel.fromJson(responseBody['data']);
    return ApiManager.returnModel(response, model: model);
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

  // static Future<AuthModel> sendVerificaionMailForPasswordChange(
  //   String email,
  // ) async {
  //   // get the token from local database
  //   final token = await UserSecureStorage.fetchToken();
  //   final url = "${AuthUrl.sendVerificationMailForPasswordReset}/$email";
  //   final response =
  //       await ApiManager.bodyLessPost(url, headers: <String, String>{
  //     "Authorization": token.toString(),
  //     "Intent": "Reset-Password",
  //     "Content-Type": "application/json"
  //   });
  //   return _getResponse(response);
  // }

  // static Future<AuthModel> changePassword(
  //   String userId,
  //   String password,
  // ) async {
  //   const url = AuthUrl.changePassword;
  //   // get the token from local database
  //   final token = await UserSecureStorage.fetchToken();

  //   try {
  //     final response = await ApiManager.putRequest(
  //         {"userId": userId, "password": password}, url,
  //         headers: <String, String>{
  //           "Content-Type": "application/json",
  //           "Authorization": token.toString(),
  //         });

  //     return _getResponse(response);
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
}
