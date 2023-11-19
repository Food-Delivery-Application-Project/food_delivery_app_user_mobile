import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class SessionController {
  static Future<ApiResponse> refreshToken({
    required String id,
    required String token,
  }) async {
    const url = "${AppUrl.baseUrl}/refresh-token";

    final response = await ApiManager.postRequest(
      {"_id": id},
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ApiResponse.fromJson(body, (p0) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
