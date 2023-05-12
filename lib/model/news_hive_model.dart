// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part "news_hive_model.g.dart";

@HiveType(typeId: 0)
class NewsHiveModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? url;

  @HiveField(6)
  String? urlToImage;

  @HiveField(7)
  String? publishedAt;

  @HiveField(8)
  String? content;

  NewsHiveModel({
    this.id,
    this.name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
}
