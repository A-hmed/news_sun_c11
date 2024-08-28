import 'package:news_sun_c11/data/repositories/news_repository/data_sources/news_offline_data_source.dart';

import '../../../model/source_response.dart';

class NewsOfflineDataSourceImpl2 extends NewsOfflineDataSource {
  @override
  Future<SourceResponse> getSources(String categoryId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

  @override
  void saveSources(String categoryId, SourceResponse sourcesResponse) {
    // TODO: implement saveSources
  }
// Firestore firestore;
// NewsOfflineDataSourceImpl(this.hiveManager);
//
// Future<SourceResponse> getSources(String categoryId) async {
//   return firestore.getSources(categoryId);
// }
//
// void saveSources(String categoryId, SourceResponse sourcesResponse) async {
//   await firestore.saveSources(sourcesResponse, categoryId);
// }
}
