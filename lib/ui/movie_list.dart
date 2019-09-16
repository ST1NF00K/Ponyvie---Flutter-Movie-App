import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ponyvie/blocs/movies_bloc.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/ui/movie_detail.dart';

class MovieList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }

}
class MovieListState extends State<MovieList> {
  MoviesBloc bloc;
  @override

  void initState(){
    bloc = MoviesBloc();
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose(){
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(1.0)
            ),
            child: GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailpage(snapshot.data, index),
            ),
          ),
          );
        });
  }

  openDetailpage(ItemModel data, int index){
    final movie = data.results[index];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
         return BlocProvider(
          blocs: [
        Bloc((i) => MoviesBloc()),
      ],
          child: MovieDetail(
            title: movie.title,
            posterUrl: movie.backdropPath,
            description: movie.overview,
            releaseDate: movie.releasDate,
            voteAverage: movie.voteAverage.toString(),
            movieId: movie.id,
          ),
        );
      }),
    );
  }
}