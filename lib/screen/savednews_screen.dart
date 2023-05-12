import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_proyek/model/news_model.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:news_app_proyek/widget/card_widget.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => SavedNewsScreenState();
}

class SavedNewsScreenState extends State<SavedNewsScreen> {
  late final Box newsHiveBox;

  @override
  void initState() {
    newsHiveBox = Hive.box('newsHiveBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bookmark',
          style: appBarTitle,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: newsHiveBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var box = value;
                  var getData = box.getAt(index);
                  return CardWidget(
                    data: NewsModel(
                      source: Source(id: getData.id, name: getData.name),
                      title: getData.title,
                      url: getData.url,
                      publishedAt: getData.publishedAt,
                      author: getData.author,
                      content: getData.content,
                      description: getData.description,
                      urlToImage: getData.urlToImage,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: newsHiveBox.length,
              ),
            );
          }
        },
      ),
    );
  }
}
