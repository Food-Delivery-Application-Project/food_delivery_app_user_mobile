import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

abstract class StoriesController {
  static Future<ApiResponse> fetchAllStories({
    required String id,
    required String token,
  }) async {
    const url = "${AppUrl.baseUrl}/get/store/of/a/product";

    final response = await ApiManager.getRequest(url);
    final status = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (status == 200 || status == 201) {
      return ApiResponse.fromJson(responseBody, (p0) => null);
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
