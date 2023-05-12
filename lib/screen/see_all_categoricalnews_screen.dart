import 'package:flutter/material.dart';
import 'package:news_app_proyek/utils/utils.dart';

import '../widget/tabbar_widget.dart';

class SeeAllCategoricalNewsScreen extends StatefulWidget {
  const SeeAllCategoricalNewsScreen({super.key});

  @override
  State<SeeAllCategoricalNewsScreen> createState() =>
      _SeeAllCategoricalNewsScreenState();
}

class _SeeAllCategoricalNewsScreenState
    extends State<SeeAllCategoricalNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Categories',
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
      body: const Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: TabbarWidget(
          seeAll: true,
        ),
      ),
    );
  }
}
