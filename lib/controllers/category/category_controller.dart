import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/category/category_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

class CategoryController {
  static Future<ApiResponse<List<CategoryModel>>> getAllCategories() async {
    List<CategoryModel> list = [];

    const url = "${AppUrl.baseUrl}/get-catogray";
    final response = await ApiManager.getRequest(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final categories = body['data'];
      list = categories
          .map<CategoryModel>((item) => CategoryModel.fromJson(item))
          .toList();

      return ApiResponse.fromJson(body, (p0) => list);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
