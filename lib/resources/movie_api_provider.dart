import 'dart:async';
import 'package:ponyvie/models/genre_model.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/models/popular_movies_model.dart';
import 'package:ponyvie/models/trailer_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider{
  Client client = Client();
  final _apiKey = "2d7e485ac7dfac771e6658ea2c678308";
  final _baseURL = "http://api.themoviedb.org/3/movie";
  final dataException = Exception('failed to laod data');

  Future<GenreModel> fetchGenreList() async {
    final response = await client
    .get("https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=$_apiKey");
    if(response.statusCode == 200){
      return GenreModel.fromJson(json.decode(response.body));
    } else {
      throw dataException;
    }
  }

  Future<ItemModel> fetchMovieList() async{
    final response = await client
        .get("$_baseURL/popular?api_key=$_apiKey");
    if(response.statusCode == 200){
      return ItemModel.fromJSON(json.decode(response.body));
    }
    else{
      throw dataException;
    }
  }

  Future<PopularMoviesModel> fetchPopularMovieList() async{
    final response = await client
        .get("$_baseURL/popular?api_key=$_apiKey");

    if(response.statusCode == 200){
      return PopularMoviesModel.fromJSON(json.decode(response.body));
    }
    else{
      throw dataException;
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client
        .get("$_baseURL/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}