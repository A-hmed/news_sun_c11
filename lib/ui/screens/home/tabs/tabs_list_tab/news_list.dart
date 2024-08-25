import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_sun_c11/data/api_manager.dart';
import 'package:news_sun_c11/data/model/article.dart';
import 'package:news_sun_c11/data/model/articles_response.dart';
import 'package:news_sun_c11/data/model/source.dart';
import 'package:news_sun_c11/ui/widgets/loading_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../widgets/error_view.dart';

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
        itemBuilder: (context, index) =>
            mapArticleToNewsWidget(context, list[index]));
  }

  Widget mapArticleToNewsWidget(BuildContext context, Article article) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: article.urlToImage ?? "",
          placeholder: (context, url) => LoadingView(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: MediaQuery.of(context).size.height * .25,
        ),
        Text(article.source?.name ?? ""),
        Text(article.title ?? ""),
        Text(formatTimeAgo(article.publishedAt ?? ""))
      ],
    );
  }

  String formatTimeAgo(String dateString) {
    // Parse the ISO 8601 date string
    DateTime dateTime = DateTime.parse(dateString);

    // Return the formatted time ago string
    return timeago.format(dateTime);
  }
}
