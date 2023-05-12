import 'package:flutter/material.dart';
import 'package:news_app_proyek/service/news_service.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:news_app_proyek/widget/card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController,
          style: appBarTitle.copyWith(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15.3),
            border: InputBorder.none,
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Search News Here",
            suffixIcon: IconButton(
              onPressed: searchController.clear,
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          ),
          onEditingComplete: () {
            setState(() {
              query = searchController.text;
            });
          },
        ),
      ),
      body: query != ""
          ? FutureBuilder(
              future: newsService.getNewsSearch(query),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CardWidget(data: snapshot.data[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox.shrink(),
                      itemCount: snapshot.data.length,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: Text('Empty'),
            ),
    );
  }
}
