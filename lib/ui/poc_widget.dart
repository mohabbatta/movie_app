import 'package:flutter/material.dart';
import 'package:movie_app/bloc/deep_link_bloc.dart';
import 'package:movie_app/ui/movie_details/movie_detail.dart';
import 'package:provider/provider.dart';

class PocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          var segments = data.split("/");

          if (segments.contains("details_screen")) {
            var idStr = segments[segments.length - 1];
            var id = int.parse(idStr);
            return MovieDetail(id: id);
          }
          print(snapshot.data);
          return Center(child: Text("${snapshot.data}"));
        }
        return Center(child: Text("no thang"));
      },
    );
  }
}
