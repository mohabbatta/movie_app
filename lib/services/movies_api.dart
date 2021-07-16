import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/constants/server_endpoints.dart';
import 'package:movie_app/models/movie_detail_reponse.dart';
import 'package:movie_app/models/popular_movies_response.dart';
import 'dart:developer' as developer;

class MoviesApi {
  Future<PopularMoviesResponse> getMovies({int nextPage}) async {
    print("api started");

    Response response = await Dio().get(
        ServerEndPoints.serverPath + ServerEndPoints.getPopularMovies,
        queryParameters: {
          "api_key": "04efb4789b6885a2f87e6bc96e26a9a4",
          "language": "en-US",
          "page": nextPage,
        });
    developer.log(
      'log me',
      name: 'api header',
      error: response.headers,
    );
    developer.log(
      'log me',
      name: 'api header',
      error: response,
    );


    if (response.statusCode == 200) {
      PopularMoviesResponse popularMoviesResponse =
          PopularMoviesResponse.fromJson(response.data);
      return popularMoviesResponse;
    } else if (response.statusCode == 422) {
      print(response.statusMessage);
    } else {
      print(response.statusCode);
    }

    return PopularMoviesResponse();
  }

  Future<MovieResponse> getMovieDetail({@required int movieId}) async {
    print("api started");

    try{
      Response response = await Dio().get(
          ServerEndPoints.serverPath + ServerEndPoints.getMovieDetail(movieId),
          queryParameters: {
            "api_key": "04efb4789b6885a2f87e6bc96e26a9a4",
            "language": "en-US",
          });

      if (response.statusCode == 200) {
        MovieResponse movieResponse = MovieResponse.fromJson(response.data);
        return movieResponse;
      } else if (response.statusCode == 422) {
        print(response.statusMessage);
      } else {
        print(response.statusCode);
      }

      return MovieResponse();
    }on DioError catch(e){
      rethrow;
    }

  }
}
