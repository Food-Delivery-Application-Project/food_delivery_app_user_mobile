import 'dart:convert';

import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/story/story_model.dart';
import 'package:food_delivery_app/utils/api_manager.dart';

abstract class StoriesController {
  static Future<ApiResponse<List<StoryModel>>> fetchAllStories() async {
    const url = "${AppUrl.baseUrl}/get/store/of/a/product";

    final response = await ApiManager.getRequest(url);
    final status = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (status == 200 || status == 201) {
      List<StoryModel> stories = [];
      responseBody['data'].forEach((story) {
        stories.add(StoryModel.fromJson(story));
      });
      return ApiResponse.fromJson(responseBody, (p0) => stories);
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
