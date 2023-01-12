import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/TopRatedMovie.dart';
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
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff343534),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2${topRatedList[index].posterPath}',
                                  fit: BoxFit.fill,
                                  width: 90,
                                ),
                                Image.asset('assets/images/bookmark.png'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/star.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${topRatedList[index].voteAverage}',
                                style: TextStyle(
                                  color: MyColor.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${topRatedList[index].title}',
                            style: TextStyle(
                                color: MyColor.whiteColor,
                                overflow: TextOverflow.ellipsis),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${topRatedList[index].releaseDate}',
                            style: const TextStyle(
                              color: Color(0xffB5B4B4),
                            ),
                          ),
                        ],
                      ),
                    );
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
