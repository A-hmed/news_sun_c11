import '../../../model/source_response.dart';

abstract class NewsOfflineDataSource {
  Future<SourceResponse> getSources(String categoryId);

  void saveSources(String categoryId, SourceResponse sourcesResponse);
}
