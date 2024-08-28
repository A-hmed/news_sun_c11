import 'package:news_sun_c11/data/hive_manager.dart';

import '../../../model/source_response.dart';

class NewsOfflineDataSource {
  HiveManager hiveManager = HiveManager();

  Future<SourceResponse> getSources(String categoryId) async {
    return hiveManager.getSources(categoryId);
  }

  void saveSources(String categoryId, SourceResponse sourcesResponse) async {
    await hiveManager.saveSources(sourcesResponse, categoryId);
  }
}
