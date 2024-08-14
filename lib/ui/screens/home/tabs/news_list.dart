import 'package:flutter/material.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/article.dart';
import 'package:news_sun_c11/data/model/articles_response.dart';
import 'package:news_sun_c11/data/model/source.dart';
import 'package:news_sun_c11/ui/widgets/loading_view.dart';

import '../../../widgets/error_view.dart';

class NewsList extends StatelessWidget {
  final Source source;

  const NewsList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticlesResponse>(
        future: ApiManager.getArticles(source.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
                error: snapshot.error.toString(), onRetryClick: () {});
          } else if (snapshot.hasData) {
            return buildNewsList(snapshot.data!.articles!);
          } else {
            return LoadingView();
          }
        });
  }

  Widget buildNewsList(List<Article> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => mapArticleToNewsWidget(list[index]));
  }

  Widget mapArticleToNewsWidget(Article article) {
    return Column(
      children: [
        Image.network(article.urlToImage ?? ""),
        Text(article.source?.name ?? ""),
        Text(article.title ?? ""),
        Text(article.publishedAt ?? "")
      ],
    );
  }
}
