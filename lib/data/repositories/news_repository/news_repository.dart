import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_sun_c11/data/model/source_response.dart';
import 'package:news_sun_c11/data/repositories/news_repository/data_sources/news_offline_data_source.dart';
import 'package:news_sun_c11/data/repositories/news_repository/data_sources/news_remote_data_source.dart';

class NewsRepository {
  NewsRemoteDataSource newsRemoteDataSource = NewsRemoteDataSource();
  NewsOfflineDataSource newsOfflineDataSource = NewsOfflineDataSource();

  Future<SourceResponse> getSources(String categoryId) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      SourceResponse sourceResponse =
          await newsRemoteDataSource.getSources(categoryId);
      newsOfflineDataSource.saveSources(categoryId, sourceResponse);
      return sourceResponse;
    } else {
      return newsOfflineDataSource.getSources(categoryId);
    }
  }
}
