import 'package:movie_app/models/popular_movies_response.dart';
import 'package:movie_app/services/movies_api.dart';

class Repository {
  int nextPage;
  Repository({this.nextPage});
  Future<PopularMoviesResponse> get getMovies =>
      MoviesApi().getMovies(nextPage: nextPage);
}
