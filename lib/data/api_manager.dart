import 'dart:convert';

import 'package:news_sun_c11/data/model/articles_response.dart';
import 'package:news_sun_c11/data/model/source_response.dart';
import 'package:http/http.dart';

abstract class ApiManager {
  static const String _apiKey = "a2803275cc264f5ab82151862011361a";
  static const String _baseUrl = "https://newsapi.org";
  static const String _sourcesEndPoint = "/v2/top-headlines/sources";
  static const String _articlesEndPoint = "/v2/everything";

  static Future<SourceResponse> getSources(String categoryId) async {
    Response serverResponse = await get(Uri.parse(
        '$_baseUrl$_sourcesEndPoint?apiKey=$_apiKey&category=$categoryId'));
    if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
      Map json = jsonDecode(serverResponse.body) as Map;
      SourceResponse response = SourceResponse.fromJson(json);
      print("getSources: sources = ${response.sources}");
      return response;
    }else {
      throw "Something went wrong please try again later";
    }
  }

  static Future<ArticlesResponse> getArticles(String sourceId) async {
    Response serverResponse =
    await get(Uri.parse('$_baseUrl$_articlesEndPoint?apiKey=$_apiKey&sources=$sourceId'));
    if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
      Map json = jsonDecode(serverResponse.body) as Map;
      return ArticlesResponse.fromJson(json);
    }else {
      throw "Something went wrong please try again later";
    }
  }
}

