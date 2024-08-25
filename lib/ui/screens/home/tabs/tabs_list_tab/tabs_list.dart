import 'package:flutter/material.dart';
import 'package:news_sun_c11/ui/base/base_api_state.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/tabs_list_tab/news_list.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/tabs_list_tab/tabs_view_model.dart';
import 'package:news_sun_c11/ui/widgets/error_view.dart';
import 'package:news_sun_c11/ui/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/source.dart';

class TabsList extends StatefulWidget {
  final String categoryId;

  const TabsList(this.categoryId, {super.key});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  TabsViewModel viewModel = TabsViewModel();
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      builder: (context, _) {
        viewModel = Provider.of(context);
        if (viewModel.sourcesApiState is BaseLoadingState) {
          return const LoadingView();
        } else if (viewModel.sourcesApiState is BaseErrorState) {
          String errorMessage =
              (viewModel.sourcesApiState as BaseErrorState).errorMessage;
          return ErrorView(error: errorMessage, onRetryClick: () {});
        } else {
          List<Source> sources =
              (viewModel.sourcesApiState as BaseSuccessState<List<Source>>)
                  .data;
          return buildTabsList(sources);
        }
      },
    );
    // return FutureBuilder<SourceResponse>(
    //     future: ApiManager.getSources(widget.categoryId),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return ErrorView(
    //             error: snapshot.error.toString(), onRetryClick: () {});
    //       } else if (snapshot.hasData) {
    //
    //       } else {
    //         return const LoadingView();
    //       }
    //     });
  }

  Widget buildTabsList(List<Source> sources) {
    List<Widget> tabs = sources
        .map((source) =>
            mapSourceToTab(source, selectedTabIndex == sources.indexOf(source)))
        .toList();
    List<Widget> tabsBody =
        sources.map((source) => NewsList(source: source)).toList();
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          TabBar(
            tabs: tabs,
            onTap: (index) {
              selectedTabIndex = index;
              setState(() {});
            },
            isScrollable: true,
            indicatorColor: Colors.transparent,
          ),
          Expanded(child: TabBarView(children: tabsBody))
        ],
      ),
    );
  }

  Widget mapSourceToTab(Source source, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue, width: 3),
          color: isSelected ? Colors.blue : Colors.white),
      child: Text(
        source.name ?? "",
        style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
      ),
    );
  }
}
