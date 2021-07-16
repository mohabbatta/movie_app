import 'package:movie_app/models/movie_model.dart';

class PopularMoviesResponse {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  PopularMoviesResponse(
      {this.page, this.movies, this.totalPages, this.totalResults});

  PopularMoviesResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
