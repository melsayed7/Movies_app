import 'package:flutter/material.dart';
import 'package:movie_app/shared/style/myColor.dart';

class SearchScreenItem extends StatelessWidget {
  String image;

  String title;

  String date;

  String content;

  SearchScreenItem({
    required this.image,
    required this.title,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Image.network(
                'https://image.tmdb.org/t/p/w600_and_h900_bestv2$image'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: MyColor.whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: TextStyle(color: MyColor.whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  content,
                  style: TextStyle(color: MyColor.whiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
