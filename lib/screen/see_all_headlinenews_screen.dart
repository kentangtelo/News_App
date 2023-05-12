import 'package:flutter/material.dart';
import 'package:news_app_proyek/service/news_service.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:news_app_proyek/widget/card_widget.dart';

class SeeAllHeadlineNewsScreen extends StatefulWidget {
  const SeeAllHeadlineNewsScreen({super.key});

  @override
  State<SeeAllHeadlineNewsScreen> createState() =>
      _SeeAllHeadlineNewsScreenState();
}

class _SeeAllHeadlineNewsScreenState extends State<SeeAllHeadlineNewsScreen> {
  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Headlines',
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
        ),
        child: FutureBuilder(
          future: newsService.getNewsHeadlines(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return CardWidget(
                    data: snapshot.data[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: snapshot.data.length,
              );
            }
          },
        ),
      ),
    );
  }
}
