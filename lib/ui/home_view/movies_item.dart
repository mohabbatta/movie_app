import 'package:flutter/material.dart';
import 'package:movie_app/constants/server_endpoints.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details/movie_detail.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({@required this.movie, Key key})
      : assert(movie != null),
        super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetail(
                  id: movie.id,),
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    ServerEndPoints.getImagePath(movie.posterPath),
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        movie.title,
                        style: textTheme.subtitle1,
                      ),
                      Text(
                        movie.originalLanguage,
                        style: textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          SmoothStarRating(
                              allowHalfRating: true,
                              onRated: (v) {},
                              starCount: 5,
                              rating: movie.voteAverage / 2,
                              size: 25.0,
                              isReadOnly: true,
                              color: Colors.black,
                              borderColor: Colors.black,
                              spacing: 0.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text("${movie.voteAverage}"),
                          ),
                        ],
                      ),
                      Text(
                       "Release ${ movie.releaseDate}",
                        style: textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
