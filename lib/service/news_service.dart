import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_proyek/model/news_model.dart';

class NewsService {
  //Fadhil
  // String apiKey = 'bac75f6dec3e4f0c94e58a5310f36acb';
  // Iman
  String apiKey = 'de17e0f00c9f40cc85b339998d6dbb40';
  // String apiKey = 'cab817200f92426bacb4edd2373e82ef';
  String baseUrl = 'https://newsapi.org/v2/';

  Future getNewsHeadlines() async {
    Uri url = Uri.parse('${baseUrl}top-headlines?country=us&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['articles'].map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed Load News Headlines');
    }
  }

  Future getNewsCategorical(String category) async {
    Uri url = Uri.parse(
        '${baseUrl}top-headlines?country=us&category=$category&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['articles'].map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed Load News Categorical');
    }
  }

  Future getNewsSearch(String query) async {
    Uri url = Uri.parse('${baseUrl}everything?q=$query&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['articles'].map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed Load News Search');
    }
  }
}
