// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;

import 'data/data_module.dart' as _i12;
import 'data/hive_manager.dart' as _i3;
import 'data/repositories/news_repository/data_sources/news_offline_data_source.dart'
    as _i5;
import 'data/repositories/news_repository/data_sources/news_offline_data_source_impl.dart'
    as _i6;
import 'data/repositories/news_repository/data_sources/news_remote_data_source.dart'
    as _i7;
import 'data/repositories/news_repository/data_sources/news_remote_data_source_impl.dart'
    as _i8;
import 'data/repositories/news_repository/news_repository.dart' as _i9;
import 'data/repositories/news_repository/news_respository_impl.dart' as _i10;
import 'ui/screens/home/tabs/tabs_list_tab/tabs_view_model.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    gh.factory<_i3.HiveManager>(() => _i3.HiveManager());
    gh.singleton<_i4.InternetConnectionChecker>(
        () => dataModule.getInternetConnectionCheck());
    gh.factory<_i5.NewsOfflineDataSource>(
        () => _i6.NewsOfflineDataSourceImpl(gh<_i3.HiveManager>()));
    gh.factory<_i7.NewsRemoteDataSource>(() => _i8.NewsRemoteDataSourceImpl());
    gh.factory<_i9.NewsRepository>(() => _i10.NewsRepositoryImpl(
          gh<_i7.NewsRemoteDataSource>(),
          gh<_i5.NewsOfflineDataSource>(),
          gh<_i4.InternetConnectionChecker>(),
        ));
    gh.factory<_i11.TabsViewModel>(
        () => _i11.TabsViewModel(gh<_i9.NewsRepository>()));
    return this;
  }
}

class _$DataModule extends _i12.DataModule {}
