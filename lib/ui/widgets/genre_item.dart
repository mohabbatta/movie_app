import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  const GenreItem({
    Key key, @required this.name,
  }) : super(key: key);

  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              color: Colors.blueGrey, width: 1.5)),
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name),
          )),
    );
  }
}
