import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/source_response.dart';

class NewsRemoteDataSource {
  Future<SourceResponse> getSources(String categoryId) async {
    return ApiManager.getSources(categoryId);
  }
}
