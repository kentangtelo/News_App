import 'package:flutter/material.dart';
import 'package:news_app_proyek/service/shared_pref.dart';
import 'package:news_app_proyek/utils/utils.dart';
import 'package:news_app_proyek/widget/card_widget.dart';

import '../model/news_model.dart';

class LikedNewsScreen extends StatefulWidget {
  const LikedNewsScreen({super.key});

  @override
  State<LikedNewsScreen> createState() => _LikedNewsScreenState();
}

class _LikedNewsScreenState extends State<LikedNewsScreen> {
  var likedData = [];

  getLikedData() async {
    var data = await SharedPref.getLikedData();

    setState(() {
      likedData = data.map((json) => NewsModel.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getLikedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Liked',
          style: appBarTitle,
        ),
      ),
      body: likedData.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CardWidget(
                    data: likedData[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: likedData.length,
              ),
            )
          : const Center(
              child: Text('Empty'),
            ),
    );
  }
}
