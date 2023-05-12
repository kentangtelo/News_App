// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:news_app_proyek/model/news_model.dart';
import 'package:news_app_proyek/service/shared_pref.dart';

import '../screen/detailnews_screen.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class CardWidget extends StatefulWidget {
  NewsModel data;
  CardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  int? index;
  bool isLiked = false;
  getLiked() async {
    var data = await SharedPref.getLikedData();
    if (data == []) {
      isLiked = false;
    }
    if (data != []) {
      for (var i = 0; i < data.length; i++) {
        if (data[i]['title'] == widget.data.title) {
          setState(() {
            isLiked = true;
            index = i;
          });
        }
      }
    }
  }

  likeData() async {
    var newsLike = {
      'source': {
        'id': widget.data.source.id,
        'name': widget.data.source.name,
      },
      'author': widget.data.author,
      'title': widget.data.title,
      'description': widget.data.description,
      'url': widget.data.url,
      'urlToImage': widget.data.urlToImage,
      'publishedAt': widget.data.publishedAt,
      'content': widget.data.content
    };
    var data = await SharedPref.getLikedData();
    data.insert(0, newsLike);
    await SharedPref.likedData(data);
  }

  deleteLikeData() async {
    var data = await SharedPref.getLikedData();
    data.removeAt(index);
    await SharedPref.likedData(data);
  }

  @override
  void initState() {
    super.initState();
    getLiked();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.only(right: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailNewsScreen(
                  data: widget.data,
                ),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 90,
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.data.urlToImage!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      'https://btklsby.go.id/images/placeholder/basic.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      widget.data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        time(DateTime.parse(widget.data.publishedAt!)),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    isLiked = !isLiked;
                    if (isLiked == true) {
                      likeData();
                    } else {
                      deleteLikeData();
                    }
                  });
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
