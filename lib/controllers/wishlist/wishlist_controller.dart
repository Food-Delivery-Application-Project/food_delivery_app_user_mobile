import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class WishlistController {
  static Future<ApiResponse<dynamic>> addOrRemoveItemToWishList(
    String userId,
    String foodId,
  ) async {
    const url = "${AppUrl.baseUrl}/add-or-remove-food-item-to-wishlist";
    final response = await ApiManager.postRequest(
      {"userId": userId, "foodId": foodId},
      url,
      headers: {
        "Content-Type": "application/json",
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
