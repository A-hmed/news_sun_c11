import 'package:flutter/material.dart';
import 'package:news_sun_c11/data/model/category.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/settings/settings.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/tabs_list_tab/tabs_list.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget currentWidgetBody;

  @override
  void initState() {
    super.initState();
    currentWidgetBody = CategoriesTab(onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          /// If current tab is categories then we should close the app
          if (currentWidgetBody is CategoriesTab) {
            return true;
          } else {
            /// Here the current is settings or tabs list then
            /// we should navigate back to categories
            currentWidgetBody = CategoriesTab(onCategoryClick);
            setState(() {});
            return false;
          }
        },
        child: Scaffold(
          appBar: buildAppBar(),
          body: currentWidgetBody,
          drawer: buildDrawer(),
        ),
      ),
    );
  }

  void onCategoryClick(Category category) {
    currentWidgetBody = TabsList(category.backEndId);
    setState(() {});
  }

  buildDrawer() => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildDrawerHeader(),
            buildDrawerRow(Icons.settings, "Settings", () {
              currentWidgetBody = SettingsTab();
              Navigator.pop(context);
              setState(() {});
            }),
            buildDrawerRow(Icons.list, "Categories", () {
              currentWidgetBody = CategoriesTab(onCategoryClick);
              Navigator.pop(context);
              setState(() {});
            })
          ],
        ),
      );

  Widget buildDrawerHeader() => Container(
      color: Colors.blue,
      height: MediaQuery.of(context).size.height * .15,
      child: const Center(
          child: Text(
        "NewsApp",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 24),
      )));

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("News app"),
      centerTitle: true,
      toolbarHeight: MediaQuery.of(context).size.height * .08,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28))),
    );
  }

  buildDrawerRow(IconData iconData, String title, void Function() onClick) =>
      InkWell(
        onTap: () {
          onClick();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 34,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}

///
