import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_sun_c11/data/repositories/news_repository/news_repository.dart';

import '../../model/source_response.dart';
import 'data_sources/news_offline_data_source.dart';
import 'data_sources/news_remote_data_source.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl extends NewsRepository {
  NewsRemoteDataSource newsRemoteDataSource;
  NewsOfflineDataSource newsOfflineDataSource;
  InternetConnectionChecker internetConnectionChecker;

  NewsRepositoryImpl(this.newsRemoteDataSource, this.newsOfflineDataSource,
      this.internetConnectionChecker);

  Future<SourceResponse> getSources(String categoryId) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
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
