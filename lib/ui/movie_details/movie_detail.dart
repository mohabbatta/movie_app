import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/server_endpoints.dart';
import 'package:movie_app/models/movie_detail_reponse.dart';
import 'package:movie_app/services/movies_api.dart';
import 'package:movie_app/ui/widgets/genre_item.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
      body: FutureBuilder<MovieResponse>(
        future: MoviesApi().getMovieDetail(movieId: widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data.title),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                ServerEndPoints.getImagePath(
                                  snapshot.data.posterPath,
                                ),
                              ),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${snapshot.data.voteAverage} / 10"),
                        SizedBox(width: 10),
                        SmoothStarRating(
                            allowHalfRating: true,
                            onRated: (v) {},
                            starCount: 5,
                            rating: snapshot.data.voteAverage / 2,
                            size: 25.0,
                            isReadOnly: true,
                            color: Colors.black,
                            borderColor: Colors.black,
                            spacing: 0.0)
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${snapshot.data.status} ${snapshot.data.releaseDate} ${snapshot.data.runtime}M ",
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.genres.length,
                          itemBuilder: (context, index) {
                            return GenreItem(
                              name: snapshot.data.genres[index].name,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 8);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        snapshot.data.overview,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              ServerEndPoints.getImagePath(snapshot
                                  .data.productionCompanies[0].logoPath),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                          Column(
                            children: [
                              Text(snapshot.data.productionCompanies[0].name),
                              Text(snapshot
                                  .data.productionCompanies[0].originCountry),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("404 not found"),
            );
          }
          return Center(
              child: CircularProgressIndicator(
          ));
        },
      ),
    );
  }
}
