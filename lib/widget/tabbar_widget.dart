import 'package:flutter/material.dart';
import 'package:news_app_proyek/widget/card_widget.dart';

import '../service/news_service.dart';

class TabbarWidget extends StatefulWidget {
  final bool? seeAll;
  const TabbarWidget({super.key, this.seeAll = false});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<Tab> myTab = [
    const Tab(
      text: "Business",
    ),
    const Tab(
      text: "Entertainment",
    ),
    const Tab(
      text: "General",
    ),
    const Tab(
      text: "Health",
    ),
    const Tab(
      text: "Science",
    ),
    const Tab(
      text: "Sport",
    ),
    const Tab(
      text: "Technology",
    )
  ];
  @override
  void initState() {
    tabController = TabController(length: myTab.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    return SizedBox(
      height: widget.seeAll! ? MediaQuery.of(context).size.height : 1150,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: myTab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
            ),
            labelStyle: const TextStyle(fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: myTab.map((Tab tab) {
                return FutureBuilder(
                  future: newsService
                      .getNewsCategorical(tab.text.toString().toLowerCase()),
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
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          primary: false,
                          itemBuilder: (context, index) {
                            return CardWidget(
                              data: snapshot.data[index],
                            );
                          },
                          itemCount: widget.seeAll! ? snapshot.data.length : 10,
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
