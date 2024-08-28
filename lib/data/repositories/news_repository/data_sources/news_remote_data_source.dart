import 'package:news_sun_c11/data/model/source_response.dart';

abstract class NewsRemoteDataSource {
  Future<SourceResponse> getSources(String categoryId);
}
