
import 'dart:developer';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class HomeScreenServices {
  Future<ArticlesModel?> getTopHeadLineApi() async {
    try {
      final response = await DioHelper.getrequest(
        endpoint: ApiEndpoints.topHeadlinesEndpoint,
        query: {
          'country': 'us',
          'apiKey': AppConstants.ApiKeys,
        },
      );

      if (response != null && response.statusCode == 200) {
        final topHeadlinesModel = ArticlesModel.fromJson(response.data);
        log(topHeadlinesModel.totalResults.toString());
        return topHeadlinesModel;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}