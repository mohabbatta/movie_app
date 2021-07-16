import 'package:dio/dio.dart';
import 'package:movie_app/constants/server_endpoints.dart';
import 'package:movie_app/models/movie_detail_reponse.dart';
import 'package:movie_app/models/popular_movies_response.dart';

class MoviesApi {
  Future<PopularMoviesResponse> getMovies({int nextPage}) async {
    print("api started");

    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String token = _prefs.getString("userToken");
    // print(token);
    //
    // String lang = await EasyLocalization.of(context).currentLocale.languageCode;
    //
    // print("${name}    $email     $mobile");

    Response response = await Dio().get(
        ServerEndPoints.serverPath + ServerEndPoints.getPopularMovies,
        queryParameters: {
          "api_key": "04efb4789b6885a2f87e6bc96e26a9a4",
          "language": "en-US",
          "page": nextPage,
        });

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

  Future<MovieResponse> getMovieDetail({int movieId}) async {
    print("api started");

    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String token = _prefs.getString("userToken");
    // print(token);
    //
    // String lang = await EasyLocalization.of(context).currentLocale.languageCode;
    //
    // print("${name}    $email     $mobile");

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
  }
}
