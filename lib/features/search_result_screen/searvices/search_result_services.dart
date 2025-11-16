import 'dart:developer';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class SearchResultServices {
  Future<ArticlesModel?> SearchItemByName(String query) async {
    try {
      final response = await DioHelper.getrequest(
        endpoint: ApiEndpoints.searchEndpoint,
        query: {
          'apiKey': AppConstants.ApiKeys,
          'q': query,
          'language': 'en',
          // 'sortBy': 'publishedAt', // optional
        },
      );

      if (response != null && response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['status'] == 'ok') {
          final articlesmodel = ArticlesModel.fromJson(data);
          log(articlesmodel.totalResults.toString());
          return articlesmodel;
        } else {
          final message = data['message']?.toString() ?? 'Unknown error';
          throw Exception(message);
        }
      }
      throw Exception('Empty response');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}