import 'package:flutter/material.dart';
import 'package:movie_app/model/PopularMovie.dart';

class PopularItem extends StatelessWidget {
  Results results;

  PopularItem({required this.results});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: screenSize.height * .45,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                height: screenSize.height * .30,
                width: screenSize.width * 1,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2${results.backdropPath}',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: screenSize.height * .12,
                left: screenSize.width * .40,
                child: Image.asset('assets/images/play-button.png'),
              ),
              Positioned(
                top: screenSize.height * .01,
                left: screenSize.width * .06,
                child: Stack(
                  children: [
                    SizedBox(
                      height: screenSize.height * .51,
                      width: screenSize.width * .32,
                      child: Image.network(
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${results.posterPath}'),
                    ),
                    /*Positioned(
                      top: screenSize.height * .14,
                      left: screenSize.width * .001,
                      child: Image.asset('assets/images/bookmark.png'),
                    ),*/
                  ],
                ),
              ),
              Positioned(
                top: screenSize.height * .32,
                left: screenSize.width * .42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${results.title}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${results.releaseDate}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
