import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/detailnews_screen.dart';

import '../utils/utils.dart';

class CarouselWidget extends StatelessWidget {
  final List? data;
  const CarouselWidget({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        return SizedBox(
          height: 200,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailNewsScreen(data: data![index]),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(data![index].urlToImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.white.withOpacity(0.1)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data![index].title,
                          maxLines: 4,
                          style: titleNews,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}
