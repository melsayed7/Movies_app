import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/GenresMovieModel.dart';
import 'package:movie_app/screen/browse_screen/browse_widget_list.dart';
import 'package:movie_app/shared/style/myColor.dart';

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Category ',
          style: TextStyle(
            color: MyColor.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<GenresMovieModel>(
        future: ApiManager.getGenresMovie(),
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
                        ApiManager.getGenresMovie();
                      },
                      child: const Text('Try Again'))
                ],
              ),
            );
          }
          var genreList = snapshot.data?.genres ?? [];
          return Padding(
            padding: const EdgeInsets.all(25),
            child: GridView.builder(
              itemCount: genreList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    Navigator.of(context).pushNamed(BrowseListWidget.routeName,
                        arguments: genreList[index]);
                  },
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/bgBrowse.jpg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .07,
                        left: MediaQuery.of(context).size.width * .1,
                        child: Text(
                          '${genreList[index].name}',
                          style: TextStyle(
                            color: MyColor.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
