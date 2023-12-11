import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/user/user_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

class UserController {
  static Future<ApiResponse<UserModel>> fetchUserDetails() async {
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();

    final url = "${AppUrl.baseUrl}/get-user-detail/$userId";
    Map<String, String> headers = {"authorization": "Bearer $token"};

    try {
      var response = await ApiManager.getRequest(url, headers: headers);
      var body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.fromJson(
          body,
          (data) => UserModel.fromJson(body['data']),
        );
      } else {
        String msg = body['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
