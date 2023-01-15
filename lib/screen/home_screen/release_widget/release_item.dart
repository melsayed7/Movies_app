import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/PopularMovie.dart';
import 'package:movie_app/screen/movie_details/movie_details.dart';
import 'package:movie_app/shared/style/myColor.dart';

class ReleaseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.containerColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Releases',
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
            child: FutureBuilder<PopularMovie>(
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
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.of(context).pushNamed(MovieDetails.routeName,
                            arguments: await ApiManager.getMovieDetails(
                                popularList[index].id ?? 0));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${popularList[index].posterPath}',
                              fit: BoxFit.fitWidth,
                            ),
                            Image.asset('assets/images/bookmark.png'),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: popularList.length,
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
