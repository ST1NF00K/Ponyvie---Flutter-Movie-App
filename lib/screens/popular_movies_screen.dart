import 'package:flutter/material.dart';
import 'package:ponyvie/ui/movie_list.dart';

class PopularMoviesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MovieList(),
      );
  }

}