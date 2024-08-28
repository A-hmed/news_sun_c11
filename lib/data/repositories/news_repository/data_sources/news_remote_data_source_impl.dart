import 'package:injectable/injectable.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/source_response.dart';
import 'package:news_sun_c11/data/repositories/news_repository/data_sources/news_remote_data_source.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  Future<SourceResponse> getSources(String categoryId) async {
    return ApiManager.getSources(categoryId);
  }
}
