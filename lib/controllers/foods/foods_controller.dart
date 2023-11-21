import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class FoodController {
  static Future<ApiResponse<List<FoodModel>>> getFoodItemByCategoryId(
    int categoryId, {
    required int page,
    required int paginatedBy,
  }) async {
    List<FoodModel> list = [];

    final url =
        "${AppUrl.baseUrl}/get-food-items-by-category-id/$categoryId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final categories = body['data'];
      list = categories
          .map<FoodModel>((item) => FoodModel.fromJson(item))
          .toList();

      return ApiResponse.fromJson(body, (p0) => list);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // Random food items for slider
  static Future<ApiResponse<List<FoodModel>>> getRandomFoodsForSlider() async {
    List<FoodModel> list = [];

    const url = "${AppUrl.baseUrl}/get-random-five-fooditem";
    final response = await ApiManager.getRequest(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final categories = body['data'];
      list = categories
          .map<FoodModel>((item) => FoodModel.fromJson(item))
          .toList();

      return ApiResponse.fromJson(body, (p0) => list);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
