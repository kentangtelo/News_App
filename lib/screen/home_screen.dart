import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/see_all_categoricalnews_screen.dart';
import 'package:news_app_proyek/screen/see_all_headlinenews_screen.dart';
import 'package:news_app_proyek/service/news_service.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:news_app_proyek/widget/carousel_widget.dart';
import 'package:news_app_proyek/widget/tabbar_widget.dart';

import '../widget/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  static ScrollController scrollController = ScrollController();
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    return Scaffold(
      body: SingleChildScrollView(
        controller: HomeScreen.scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BannerWidget(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Headlines',
                    style: title,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SeeAllHeadlineNewsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: seeAll,
                    ),
                  )
                ],
              ),
              FutureBuilder(
                future: newsService.getNewsHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    var data = snapshot.data;
                    return CarouselWidget(
                      data: data,
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: title,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SeeAllCategoricalNewsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: seeAll,
                    ),
                  )
                ],
              ),
              const TabbarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
