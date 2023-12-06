import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/orders/orders_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

class OrdersController {
  static Future<ApiResponse> placeOrder({
    required double totalPrice,
    required String address,
  }) async {
    const url = "${AppUrl.baseUrl}/place-order";
    final userId = await UserSecureStorage.fetchUserId();
    final body = {
      "userId": userId,
      "totalPrice": totalPrice,
      "address": address,
    };
    final response = await ApiManager.postRequest(body, url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ApiResponse.fromJson(body, (data) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse<List<OrdersModel>>> getPlacedOrdersByUserId(
      {required int page, required int paginatedBy}) async {
    final userId = await UserSecureStorage.fetchUserId();
    List<OrdersModel> orders = [];
    final url =
        "${AppUrl.baseUrl}/get-order-by-userid/$userId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      body['data'].forEach((order) {
        orders.add(OrdersModel.fromJson(order));
      });
      return ApiResponse.fromJson(body, (data) => orders);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse<List<CartFoodModel>>> getFoodsByOrderId(
      String orderId) async {
    List<CartFoodModel> list = [];
    final url = "${AppUrl.baseUrl}/get-allorder-item-byorderid/$orderId";
    final response = await ApiManager.getRequest(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final foods = body['data'];
      list = foods
          .map<CartFoodModel>((item) => CartFoodModel.fromJson(item))
          .toList();

      return ApiResponse.fromJson(body, (data) => list);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
