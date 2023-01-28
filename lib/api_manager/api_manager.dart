import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/GenreMovieDetails.dart';
import 'package:movie_app/model/GenresMovieModel.dart';
import 'package:movie_app/model/MovieDetailModel.dart';
import 'package:movie_app/model/PopularMovie.dart';
import 'package:movie_app/model/SearchMovieModel.dart';
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

  //https://api.themoviedb.org/3/search/movie?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US&query=batman&page=1&include_adult=false

  static Future<SearchMovieModel> searchMovie(String query) async {
    var url = Uri.https(
        baseUrl, '/3/search/movie', {'api_key': apiKey, 'query': query});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var searchMovieModel = SearchMovieModel.fromJson(json);
      return searchMovieModel;
    } catch (error) {
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/genre/movie/list?api_key=58b29b46048441216fa7c3562cb5eba9&language=en-US
  static Future<GenresMovieModel> getGenresMovie() async {
    var url = Uri.https(baseUrl, '/3/genre/movie/list', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var genreMovieModel = GenresMovieModel.fromJson(json);
      return genreMovieModel;
    } catch (error) {
      rethrow;
    }
  }

  //https://api.themoviedb.org/3/discover/movie?api_key=58b29b46048441216fa7c3562cb5eba9
  // &language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false
  // &page=1&with_watch_monetization_types=flatrate

  static Future<GenreMovieDetails> genresMovieDetails(int genreID) async {
    var url = Uri.https(baseUrl, '/3/discover/movie',
        {'api_key': apiKey, "with_genres": '$genreID'});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var genreMovieDetails = GenreMovieDetails.fromJson(json);
      return genreMovieDetails;
    } catch (error) {
      rethrow;
    }
  }
}
