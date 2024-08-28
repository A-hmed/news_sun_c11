import 'package:hive_flutter/adapters.dart';
import 'package:news_sun_c11/data/model/source_response.dart';

class HiveManager {
  static void init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SourceAdapter());
  }

  Future saveSources(SourceResponse sourcesResponse, String categoryId) async {
    Box box = await Hive.openBox('news');
    box.put(categoryId, sourcesResponse);
  }

  Future<SourceResponse> getSources(String categoryId) async {
    try {
      Box box = await Hive.openBox('news');
      return box.get(categoryId);
    } catch (e) {
      throw "Please check your internet connection and try again later";
    }
  }
}

class SourceAdapter extends TypeAdapter<SourceResponse> {
  @override
  final typeId = 0;

  @override
  SourceResponse read(BinaryReader reader) {
    return SourceResponse.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, SourceResponse sourceResponse) {
    writer.write(sourceResponse.toJson());
  }
}
