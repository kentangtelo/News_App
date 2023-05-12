import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/search_screen.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/newspaper.png',
              height: 65,
            ),
            const SizedBox(width: 16),
            const Text(
              'Newspaper',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          icon: const Icon(Icons.search, size: 30),
        )
      ],
    );
  }
}
