import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/PopularMovie.dart';
import 'package:movie_app/screen/home_screen/popular_widget/popular_item.dart';
import 'package:movie_app/shared/style/myColor.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMovie>(
      future: ApiManager.getPopularMovie(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: MyColor.yellowColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(snapshot.error.toString()),
                ElevatedButton(
                    onPressed: () {
                      ApiManager.getPopularMovie();
                    },
                    child: const Text('Try Again'))
              ],
            ),
          );
        }
        var popularList = snapshot.data?.results ?? [];
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 1,
          ),
          itemCount: popularList.length,
          itemBuilder: (context, index, realIndex) =>
              PopularItem(results: popularList[index]),
        );
      },
    );
  }
}
