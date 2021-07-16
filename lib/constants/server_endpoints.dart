class ServerEndPoints {
  static const serverPath = "https://api.themoviedb.org/3";
  static const getPopularMovies = "/movie/popular";
  static getMovieDetail(int movieId) => "/movie/$movieId";
}
