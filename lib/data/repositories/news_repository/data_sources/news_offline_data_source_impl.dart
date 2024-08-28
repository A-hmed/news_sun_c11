import 'package:injectable/injectable.dart';
import 'package:news_sun_c11/data/hive_manager.dart';
import 'package:news_sun_c11/data/repositories/news_repository/data_sources/news_offline_data_source.dart';

import '../../../model/source_response.dart';

@Injectable(as: NewsOfflineDataSource)
class NewsOfflineDataSourceImpl extends NewsOfflineDataSource {
  HiveManager hiveManager;

  NewsOfflineDataSourceImpl(this.hiveManager);

  Future<SourceResponse> getSources(String categoryId) async {
    return hiveManager.getSources(categoryId);
  }

  void saveSources(String categoryId, SourceResponse sourcesResponse) async {
    await hiveManager.saveSources(sourcesResponse, categoryId);
  }
}
