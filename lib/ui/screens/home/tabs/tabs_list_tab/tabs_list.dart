import 'package:flutter/material.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/source_response.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/tabs_list_tab/news_list.dart';
import 'package:news_sun_c11/ui/widgets/error_view.dart';
import 'package:news_sun_c11/ui/widgets/loading_view.dart';

import '../../../../../data/model/source.dart';

class TabsList extends StatefulWidget {
  final String categoryId;

  const TabsList(this.categoryId, {super.key});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
        future: ApiManager.getSources(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
                error: snapshot.error.toString(), onRetryClick: () {});
          } else if (snapshot.hasData) {
            return buildTabsList(snapshot.data!.sources!);
          } else {
            return const LoadingView();
          }
        });
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
