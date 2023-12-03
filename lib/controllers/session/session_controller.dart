import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class SessionController {
  static Future<ApiResponse> refreshToken({
    required String id,
    required String token,
  }) async {
    const url = "${AppUrl.baseUrl}/refresh-token";
    final headers = <String, String>{
      "Content-Type": "application/json",
      "authorization": "Bearer $token",
    };
    final response = await ApiManager.postRequest(
      {"_id": id},
      url,
      headers: headers,
    );
    return ApiManager.returnModel(response);
  }
}
