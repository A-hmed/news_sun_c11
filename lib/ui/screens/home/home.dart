import 'package:flutter/material.dart';
import 'package:news_sun_c11/ui/screens/home/tabs/tabs_list.dart';

class Home extends StatelessWidget {
  static const String routeName = "home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: TabsList(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("News app"),
      centerTitle: true,
    );
  }
}
