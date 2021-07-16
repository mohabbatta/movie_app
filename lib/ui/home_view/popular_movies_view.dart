import 'package:flutter/material.dart';
import 'package:movie_app/ui/home_view/paged_movies_listView.dart';

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({Key key}) : super(key: key);

  @override
  _PopularMoviesViewState createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedMoviesListView(),
    );
  }
}
