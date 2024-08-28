import 'package:news_sun_c11/data/model/source_response.dart';

abstract class NewsRepository {
  Future<SourceResponse> getSources(String categoryId);
}
