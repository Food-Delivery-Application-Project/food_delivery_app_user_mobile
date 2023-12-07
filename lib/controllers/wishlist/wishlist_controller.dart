import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/wishlist/is_favorite_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

class WishlistController {
  static Future<ApiResponse> addOrRemoveItemToWishList(
    String userId,
    String foodId,
  ) async {
    const url = "${AppUrl.baseUrl}/add-or-remove-food-item-to-wishlist";
    final response =
        await ApiManager.postRequest({"userId": userId, "foodId": foodId}, url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ApiResponse.fromJson(body, (data) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // wishlist foods IDs
  static Future<ApiResponse<List<FoodModel>>> getWishlistFoods(
      {required int page, required int paginatedBy}) async {
    final userId = await UserSecureStorage.fetchUserId();
    final url =
        "${AppUrl.baseUrl}/get-food-item-to-wishlist/$userId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final List<FoodModel> foods = [];
      body['data'].forEach((food) {
        foods.add(FoodModel.fromJson(food));
      });
      return ApiResponse.fromJson(body, (data) => foods);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse> isFavorite(String userId, String foodId) async {
    final url =
        "${AppUrl.baseUrl}/get-foodid-to-wishlist/?userId=$userId&foodId=$foodId";
    final response = await ApiManager.getRequest(url);
    final body = jsonDecode(response.body);
    final isFavoriteModel = IsFavoriteModel.fromJson(body['data']);
    return ApiManager.returnModel(response, model: isFavoriteModel);
  }
}
