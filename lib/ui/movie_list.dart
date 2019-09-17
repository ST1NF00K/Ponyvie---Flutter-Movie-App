import 'package:flutter/material.dart';
import 'package:ponyvie/blocs/favorite_bloc.dart';
import 'package:ponyvie/blocs/movies_bloc.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/ui/movie_detail.dart';

class MovieList extends StatefulWidget {
  MovieList({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  FavoriteBloc favoriteBloc;
  MoviesBloc bloc;

  @override
  void initState() {
    bloc = MoviesBloc();

    favoriteBloc = FavoriteBloc.getInstance();

    
    bloc.fetchAllMovies();
    super.initState();
  }

  @override
  void dispose() {
    favoriteBloc.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(1.0)),
            child: GridTile(
              child: InkResponse(
                enableFeedback: true,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data[index].posterPath}',
                  fit: BoxFit.cover,
                ),
                onTap: () => openDetailpage(snapshot.data, index),
              ),
            ),
          );
        });
  }

  openDetailpage(List<MovieModel> data, int index) {
    final movie = data[index];
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetail(
                movieModel: movie,
              )),
    );
  }
}
