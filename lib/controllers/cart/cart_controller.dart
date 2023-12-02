import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

class CartController {
  static Future<ApiResponse<List<CartFoodModel>>> getCartItemsByUserId({
    required int page,
    required int paginatedBy,
  }) async {
    List<CartFoodModel> list = [];
    final userId = await UserSecureStorage.fetchUserId();
    final url =
        "${AppUrl.baseUrl}/get-food-item-to-addtocart/$userId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final foods = body['data'];
      list = foods
          .map<CartFoodModel>((item) => CartFoodModel.fromJson(item))
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

  // Increment or decrement
  static Future<ApiResponse<dynamic>> incrementQty(
    String userId,
    String foodId,
  ) async {
    final url =
        "${AppUrl.baseUrl}/food-item-addtocart-quantity-inc?userId=$userId&foodId=$foodId";
    final response = await ApiManager.bodyLessPut(url);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ApiResponse<dynamic>.fromJson(body, (p0) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse<dynamic>> decrementQty(
    String userId,
    String foodId,
  ) async {
    final url =
        "${AppUrl.baseUrl}/food-item-addtocart-quantity-dec?userId=$userId&foodId=$foodId";
    final response = await ApiManager.bodyLessPut(url);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ApiResponse<dynamic>.fromJson(body, (p0) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
