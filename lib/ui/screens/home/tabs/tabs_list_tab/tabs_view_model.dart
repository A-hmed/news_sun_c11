import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_sun_c11/data/model/source_response.dart';
import 'package:news_sun_c11/data/repositories/news_repository/news_repository.dart';
import 'package:news_sun_c11/ui/base/base_api_state.dart';

///BlocBuilder , BlocSelector ,
///BlocProvider ,MultiBlocProvider, BlocListener , MultiBlocListener ,
///BlocConsumer ,RepositoryProvider

@injectable
class TabsViewModel extends Cubit<TabsViewModelState> {
  NewsRepository newRepo;

  TabsViewModel(this.newRepo) : super(TabsViewModelState.initial());

  getSources(String categoryId) async {
    //TabsViewModel(FakeRepo());
    try {
      emit(TabsViewModelState(BaseLoadingState()));
      SourceResponse sourceResponse = await newRepo.getSources(categoryId);
      emit(TabsViewModelState(BaseSuccessState(sourceResponse.sources!)));
    } catch (e) {
      emit(TabsViewModelState(BaseErrorState(e.toString())));
    }
  }
}
// class MockRepo extends NewsRepository{
//   @override
//   Future<SourceResponse> getSources(String categoryId) {
//     return SourceResponse();
//   }
// }

class TabsViewModelState {
  late BaseApiState sourcesApiState;

  TabsViewModelState(this.sourcesApiState);

  TabsViewModelState.initial() {
    sourcesApiState = BaseLoadingState();
  }
}
