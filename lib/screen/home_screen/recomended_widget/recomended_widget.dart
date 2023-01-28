import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/TopRatedMovie.dart';
import 'package:movie_app/screen/home_screen/recomended_widget/recomended_item.dart';
import 'package:movie_app/shared/style/myColor.dart';

class RecomendedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.containerColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended',
            style: TextStyle(
              color: MyColor.whiteColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<TopRatedMovie>(
              future: ApiManager.getTopRatedMovie(),
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
                var topRatedList = snapshot.data?.results ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return RecomendedItem(result: topRatedList[index]);
                  },
                  itemCount: topRatedList.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 8,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
