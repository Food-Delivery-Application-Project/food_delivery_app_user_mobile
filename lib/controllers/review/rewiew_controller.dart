import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/review/review_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';

class ReviewController {
  static Future<ApiResponse> postReview(String foodId, String text) async {
    final userId = await UserSecureStorage.fetchUserId();
    const url = "${AppUrl.baseUrl}/add/post/review";
    final body = {"userId": userId, "foodId": foodId, "text": text};
    final response = await ApiManager.postRequest(body, url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ApiResponse.fromJson(body, (data) => null);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<ApiResponse> getAllReviews(
    String foodId, {
    required int page,
    required int paginatedBy,
  }) async {
    final url =
        "${AppUrl.baseUrl}/get/all/reviews/by/$foodId?page=$page&pageSize=$paginatedBy";
    final response = await ApiManager.getRequest(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final List<ReviewModel> reviews = [];
      if (body['data'] == null) return ApiResponse.fromJson(body, (data) => []);
      body['data'].forEach((review) {
        reviews.add(ReviewModel.fromJson(review));
      });
      return ApiResponse.fromJson(body, (data) => reviews);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
