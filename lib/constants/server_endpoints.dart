class ServerEndPoints {
  static const serverPath = "https://api.themoviedb.org/3";
  static const getPopularMovies = "/movie/popular";
  static const getGenres = "/genre/movie/list";
  static getMovieDetail(int movieId) => "/movie/$movieId";
  static getImagePath(String path) =>"https://image.tmdb.org/t/p/original$path";
}
