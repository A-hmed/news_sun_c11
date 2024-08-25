import 'package:flutter/material.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/source.dart';
import 'package:news_sun_c11/ui/base/base_api_state.dart';

class TabsViewModel extends ChangeNotifier {
  BaseApiState sourcesApiState = BaseLoadingState();

  getSources(String categoryId) async {
    try {
      sourcesApiState = BaseLoadingState();
      notifyListeners();
      List<Source> sources = (await ApiManager.getSources(categoryId)).sources!;
      sourcesApiState = BaseSuccessState(sources);
      notifyListeners();
    } catch (e) {
      sourcesApiState = BaseErrorState(e.toString());
      notifyListeners();
    }
  }
}
