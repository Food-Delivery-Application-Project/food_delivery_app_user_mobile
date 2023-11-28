import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
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

    final response = await ApiManager.postRequest({
      "userId": userId,
      "totalPrice": totalPrice,
      "address": address,
    }, url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ApiResponse.fromJson(body, (p0) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse<List<OrdersModel>>> getPlacedOrdersByUserId(
      {required int page, required int paginatedBy}) async {
    final userId = await UserSecureStorage.fetchUserId();
    final url =
        "${AppUrl.baseUrl}/get-order-by-userid/$userId?page=$page&pageSize=$paginatedBy";

    final response = await ApiManager.getRequest(url);
    List<OrdersModel> orders = [];

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      body['data'].forEach((order) {
        orders.add(OrdersModel.fromJson(order));
      });
      return ApiResponse.fromJson(body, (p0) => orders);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
