import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class CartController {
  static Future<ApiResponse<List<FoodModel>>> getCartItemsByUserId(
    String userId, {
    required int page,
    required int paginatedBy,
  }) async {
    List<FoodModel> list = [];

    final url =
        "${AppUrl.baseUrl}/get-food-item-to-addtocart/$userId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
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

  static Future<ApiResponse<dynamic>> addToOrRemoveFromCart(
    String userId,
    String foodId,
  ) async {
    const url = "${AppUrl.baseUrl}/add-or-remove-food-item-addtocart";
    final response = await ApiManager.postRequest(
      {
        "userId": userId,
        "foodId": foodId,
      },
      url,
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);

      return ApiResponse<dynamic>.fromJson(body, (p0) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<Map<String, dynamic>> isInCart(
    String userId,
    String foodId,
  ) async {
    final url =
        "${AppUrl.baseUrl}/get-foodid-to-addtocart?userId=$userId&foodId=$foodId";
    final response = await ApiManager.getRequest(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return body['data'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
