import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
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

  // wishlist foods IDs
  static Future<ApiResponse<List<FoodModel>>> getWishlistFoods(String userId,
      {required int page, required int paginatedBy}) async {
    final url =
        "${AppUrl.baseUrl}/get-food-item-to-wishlist/$userId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);

    print(response.body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<FoodModel> foods = [];
      body['data'].forEach((food) {
        foods.add(FoodModel.fromJson(food));
      });
      return ApiResponse.fromJson(body, (p0) => foods);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
