import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/wishlist/is_favorite_model.dart';
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

    if (response.statusCode == 200 || response.statusCode == 201) {
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

  static Future<ApiResponse<IsFavoriteModel>> isFavorite(
    String userId,
    String foodId,
  ) async {
    final url =
        "${AppUrl.baseUrl}/get-foodid-to-wishlist/?userId=$userId&foodId=$foodId";
    final response = await ApiManager.getRequest(url);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final isFavoriteModel = IsFavoriteModel.fromJson(body['data']);
      return ApiResponse.fromJson(body, (p0) => isFavoriteModel);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
