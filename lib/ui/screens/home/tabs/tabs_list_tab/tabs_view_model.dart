import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/source.dart';
import 'package:news_sun_c11/ui/base/base_api_state.dart';

///BlocBuilder , BlocSelector ,
///BlocProvider ,MultiBlocProvider, BlocListener , MultiBlocListener ,
///BlocConsumer ,RepositoryProvider
class TabsViewModel extends Cubit<TabsViewModelState> {
  TabsViewModel() : super(TabsViewModelState.initial());

  getSources(String categoryId) async {
    try {
      emit(TabsViewModelState(BaseLoadingState()));
      List<Source> sources = (await ApiManager.getSources(categoryId)).sources!;
      emit(TabsViewModelState(BaseSuccessState(sources)));
    } catch (e) {
      emit(TabsViewModelState(BaseErrorState(e.toString())));
    }
  }
}

class TabsViewModelState {
  late BaseApiState sourcesApiState;

  TabsViewModelState(this.sourcesApiState);

  TabsViewModelState.initial(){
    sourcesApiState = BaseLoadingState();
  }
}
