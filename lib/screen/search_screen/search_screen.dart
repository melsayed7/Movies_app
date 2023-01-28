import 'package:flutter/material.dart';
import 'package:movie_app/api_manager/api_manager.dart';
import 'package:movie_app/model/SearchMovieModel.dart';
import 'package:movie_app/screen/search_screen/search_item.dart';
import 'package:movie_app/shared/style/myColor.dart';

import '../movie_details/movie_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  List<Results> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    query = text;
                    ApiManager.searchMovie(query).then((value) {
                      results = value.results ?? [];
                      setState(() {});
                    });
                  } else {
                    results = [];
                    setState(() {});
                  }
                },
                onFieldSubmitted: (text) {
                  if (text.isNotEmpty) {
                    query = text;
                    ApiManager.searchMovie(query).then((value) {
                      results = value.results ?? [];
                      setState(() {});
                    });
                  } else {
                    results = [];
                    setState(() {});
                  }
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Color(0xffFFFFFF),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColor.whiteColor,
                    ),
                    fillColor: const Color(0xff514F4F),
                    filled: true),
              ),
              if (results.isEmpty)
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      Image.asset('assets/images/noMoviesFound.png'),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'No movies found',
                        style: TextStyle(color: MyColor.whiteColor),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              if (results.isNotEmpty)
                Expanded(
                  child: FutureBuilder<SearchMovieModel>(
                    future: ApiManager.searchMovie(query),
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
                                    ApiManager.searchMovie(query);
                                  },
                                  child: const Text('Try Again'))
                            ],
                          ),
                        );
                      }
                      var searchList = snapshot.data?.results ?? [];
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              Navigator.of(context).pushNamed(
                                MovieDetails.routeName,
                                arguments: await ApiManager.getMovieDetails(
                                    searchList[index].id ?? 0),
                              );
                            },
                            child: SearchItem(
                              image: searchList[index].posterPath ?? '',
                              title: searchList[index].title ?? '',
                              date: searchList[index].releaseDate ?? '',
                              content: searchList[index].overview ?? '',
                            ),
                          );
                        },
                        itemCount: searchList.length,
                        separatorBuilder: (context, index) =>
                            Divider(color: MyColor.greyColor, thickness: 1),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
