import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/MovieDetailModel.dart';
import 'package:movie_app/model/PopularMovie.dart';
import 'package:movie_app/model/SimilarMovie.dart';
import 'package:movie_app/model/TopRatedMovie.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = '58b29b46048441216fa7c3562cb5eba9';

//https://api.themoviedb.org/3/movie/popular?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US&page=1
  static Future<PopularMovie> getPopularMovie() async {
    var url = Uri.https(baseUrl, '/3/movie/popular', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var popularMovie = PopularMovie.fromJson(json);
      return popularMovie;
    } catch (error) {
      rethrow;
    }
  }

//https://api.themoviedb.org/3/movie/top_rated?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US&page=1
  static Future<TopRatedMovie> getTopRatedMovie() async {
    var url = Uri.https(baseUrl, '/3/movie/top_rated', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var topRatedMovie = TopRatedMovie.fromJson(json);
      return topRatedMovie;
    } catch (error) {
      rethrow;
    }
  }

  ////https://api.themoviedb.org/3/movie/238?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US

  static Future<MovieDetailModel> getMovieDetails(int movieID) async {
    var url = Uri.https(baseUrl, '/3/movie/$movieID', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var movieDetailModel = MovieDetailModel.fromJson(json);
      return movieDetailModel;
    } catch (error) {
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/movie/76600/similar?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US&page=1

  static Future<SimilarMovie> getSimilarMovie(int movieID) async {
    var url =
        Uri.https(baseUrl, '/3/movie/$movieID/similar', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var similarMovie = SimilarMovie.fromJson(json);
      return similarMovie;
    } catch (error) {
      rethrow;
    }
  }
}

