import 'dart:async';

import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/models/popular_movies_model.dart';
import 'package:ponyvie/models/trailer_model.dart';
import 'package:ponyvie/resources/movie_api_provider.dart';

class Repository{
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies () => movieApiProvider.fetchMovieList();

  Future<PopularMoviesModel> fetchAllPopularMovies () => movieApiProvider.fetchPopularMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) => movieApiProvider.fetchTrailer(movieId);
}