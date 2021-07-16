import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_reponse.dart';
import 'package:movie_app/services/movies_api.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: FutureBuilder<MovieResponse>(
          future: MoviesApi().getMovieDetail(movieId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
