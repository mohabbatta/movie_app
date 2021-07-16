import 'package:flutter/material.dart';
import 'package:movie_app/bloc/deep_link_bloc.dart';
import 'package:movie_app/ui/poc_widget.dart';
import 'package:movie_app/ui/home_view/popular_movies_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Provider<DeepLinkBloc>(
            create: (context) => _bloc,
            dispose: (context, bloc) => bloc.dispose(),
            child: PopularMoviesView()),
      ),
    );
  }
}
