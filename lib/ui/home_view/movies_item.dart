import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details/movie_detail.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    @required this.movie,
    Key key,
  })  : assert(movie != null),
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
                  id: movie.id,
                ),
              ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                movie.title,
                style: textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _launchURL(BuildContext context) async {
  //   final url = 'https://raywenderlich.com/redirect?uri=${article.uri}';
  //   if (Platform.isIOS || await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     Scaffold.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Could\'nt launch the article\'s URL.'),
  //       ),
  //     );
  //   }
  // }
}
