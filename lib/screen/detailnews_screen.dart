// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_proyek/model/news_hive_model.dart';

import 'package:news_app_proyek/model/news_model.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetailNewsScreen extends StatefulWidget {
  NewsModel data;
  DetailNewsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  late final Box newsHiveBox;
  bool isBookmarked = false;
  int indexBookmarked = 0;

  void initialize() {
    for (var i = 0; i < newsHiveBox.length; i++) {
      if (newsHiveBox.getAt(i).title == widget.data.title) {
        isBookmarked = true;
        indexBookmarked = i;
      }
    }
  }

  void deleteBookmark() {
    newsHiveBox.deleteAt(indexBookmarked);
  }

  void createBookmark() {
    NewsHiveModel newsHiveModel = NewsHiveModel(
      id: widget.data.source.id,
      name: widget.data.source.name,
      author: widget.data.author,
      title: widget.data.title,
      description: widget.data.description,
      content: widget.data.content,
      url: widget.data.url,
      urlToImage: widget.data.urlToImage,
      publishedAt: widget.data.publishedAt,
    );

    newsHiveBox.add(newsHiveModel);
  }

  @override
  void initState() {
    super.initState();
    newsHiveBox = Hive.box('newsHiveBox');
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.data.title,
          style: titleHeader,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
                if (isBookmarked == true) {
                  createBookmark();
                } else {
                  deleteBookmark();
                }
              });
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  widget.data.urlToImage!,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                      'https://btklsby.go.id/images/placeholder/basic.png'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.newspaper_outlined,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.data.source.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        time(DateTime.parse(widget.data.publishedAt!)),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.data.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.data.author!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.data.description!,
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            launchUrl(Uri.parse(widget.data.url));
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'Go to Website',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
